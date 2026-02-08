import (
	"strings"
	"net"
	"strconv"
)

func validIPAddress(queryIP string) string {
	if isIPv4(queryIP) {
		return "IPv4"
	} else if isIPv6(queryIP) {
		return "IPv6"
	} else {
		return "Neither"
	}
}

func isIPv4(queryIP string) bool {
	parts := strings.Split(queryIP, ".")
	if len(parts) != 4 {
		return false
	}
	for _, part := range parts {
		if len(part) == 0 || len(part) > 3 {
			return false
		}
		if part[0] == '0' && len(part) > 1 {
			return false
		}
		num, err := strconv.Atoi(part)
		if err != nil || num < 0 || num > 255 {
			return false
		}
	}
	return true
}

func isIPv6(queryIP string) bool {
	parts := strings.Split(queryIP, ":")
	if len(parts) != 8 {
		return false
	}
	for _, part := range parts {
		if len(part) == 0 || len(part) > 4 {
			return false
		}
		for _, c := range part {
			if !((c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F')) {
				return false
			}
		}
	}
	return true
}