func findInvalidIPAddresses(records []string) []string {
    var invalidIPs []string

    for _, ip := range records {
        if !isValidIP(ip) {
            invalidIPs = append(invalidIPs, ip)
        }
    }

    return invalidIPs
}

func isValidIP(ip string) bool {
    parts := strings.Split(ip, ".")
    if len(parts) != 4 {
        return false
    }

    for _, part := range parts {
        if len(part) == 0 || len(part) > 3 {
            return false
        }
        num, err := strconv.Atoi(part)
        if err != nil || num < 0 || num > 255 || (len(part) > 1 && part[0] == '0') {
            return false
        }
    }

    return true
}