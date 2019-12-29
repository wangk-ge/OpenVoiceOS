################################################################################
#
# wifi-ap
#
################################################################################

WIFI_AP_VERSION = 0.1.0
WIFI_AP_SITE = $(BR2_EXTERNAL_MYCROFTOS_PATH)/package/wifi-ap
WIFI_AP_SITE_METHOD = local
WIFI_AP_LICENSE = Apache License 2.0
WIFI_AP_LICENSE_FILES = LICENSE

define WIFI_AP_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/etc/wpa_supplicant
	$(INSTALL) -m 644 -D $(@D)/wpa_supplicant-ap0.conf \
		$(TARGET_DIR)/etc/wpa_supplicant/wpa_supplicant-ap0.conf

	mkdir -p $(TARGET_DIR)/etc/systemd/system/sys-subsystem-net-devices-ap0.device.wants
	ln -fs ../../../../usr/lib/systemd/system/wpa_supplicant@.service \
		$(TARGET_DIR)/etc/systemd/system/sys-subsystem-net-devices-ap0.device.wants/wpa_supplicant@ap0.service
	$(INSTALL) -D -m 644 $(@D)/wifi-setup.service \
                $(TARGET_DIR)/usr/lib/systemd/system/wifi-setup.service
	ln -fs ../../../../usr/lib/systemd/system/wifi-setup.service \
                $(TARGET_DIR)/etc/systemd/system/sys-subsystem-net-devices-ap0.device.wants/wifi-setup.service

	$(INSTALL) -D -m 644 $(@D)/wireless-mode-ap.service \
		$(TARGET_DIR)/usr/lib/systemd/system/wireless-mode-ap.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	ln -fs ../../../../usr/lib/systemd/system/wireless-mode-ap.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/wireless-mode-ap.service

	$(INSTALL) -D -m 644 $(@D)/wireless-mode-client.service \
                $(TARGET_DIR)/usr/lib/systemd/system/wireless-mode-client.service
        mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
        ln -fs ../../../../usr/lib/systemd/system/wireless-mode-client.service \
                $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/wireless-mode-client.service
endef

$(eval $(generic-package))
