package main

import (
	"net"
	"strings"
)

func validIPAddress(IP string) string {
	if net.ParseIP(IP) != nil {
		if strings.Contains(IP, ":") {
			return "IPv6"
		}
		return "IPv4"
	}
	return "Neither"
}