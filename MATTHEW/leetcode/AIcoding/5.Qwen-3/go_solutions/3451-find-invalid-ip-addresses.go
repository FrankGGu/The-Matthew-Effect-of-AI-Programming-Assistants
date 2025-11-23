package main

func invalidIPAddresses(logs []string) []string {
    result := []string{}
    for _, log := range logs {
        if isValidIPv4(log) {
            continue
        }
        if isValidIPv6(log) {
            continue
        }
        result = append(result, log)
    }
    return result
}

func isValidIPv4(ip string) bool {
    parts := strings.Split(ip, ".")
    if len(parts) != 4 {
        return false
    }
    for _, part := range parts {
        if len(part) == 0 || (len(part) > 1 && part[0] == '0') {
            return false
        }
        if num, err := strconv.Atoi(part); err != nil || num < 0 || num > 255 {
            return false
        }
    }
    return true
}

func isValidIPv6(ip string) bool {
    parts := strings.Split(ip, ":")
    if len(parts) != 8 {
        return false
    }
    for _, part := range parts {
        if len(part) < 1 || len(part) > 4 {
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