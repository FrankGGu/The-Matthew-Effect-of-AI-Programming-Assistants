import (
	"strconv"
	"strings"
)

func validIPAddress(IP string) string {
	if strings.Contains(IP, ".") && strings.Contains(IP, ":") {
		return "Neither"
	}

	if strings.Contains(IP, ".") {
		if isValidIPv4(IP) {
			return "IPv4"
		}
	} else if strings.Contains(IP, ":") {
		if isValidIPv6(IP) {
			return "IPv6"
		}
	}
	return "Neither"
}

func isValidIPv4(IP string) bool {
	parts := strings.Split(IP, ".")
	if len(parts) != 4 {
		return false
	}

	for _, part := range parts {
		if len(part) == 0 || len(part) > 3 {
			return false
		}
		if len(part) > 1 && part[0] == '0' {
			return false
		}
		num, err := strconv.Atoi(part)
		if err != nil {
			return false
		}
		if num < 0 || num > 255 {
			return false
		}
	}
	return true
}

func isValidIPv6(IP string) bool {
	parts := strings.Split(IP, ":")
	if len(parts) != 8 {
		return false
	}

	for _, part := range parts {
		if len(part) == 0 || len(part) > 4 {
			return false
		}
		for i := 0; i < len(part); i++ {
			char := part[i]
			if !isHexDigit(char) {
				return false
			}
		}
	}
	return true
}

func isHexDigit(c byte) bool {
	return (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F')
}