package main

func validateIPV4(ip string) bool {
    parts := strings.Split(ip, ".")
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
        for _, c := range part {
            if c < '0' || c > '9' {
                return false
            }
        }
        num, _ := strconv.Atoi(part)
        if num < 0 || num > 255 {
            return false
        }
    }
    return true
}

func validateIPV6(ip string) bool {
    parts := strings.Split(ip, ":")
    if len(parts) != 8 {
        return false
    }
    for _, part := range parts {
        if len(part) < 1 || len(part) > 4 {
            return false
        }
        for _, c := range part {
            if (c < '0' || c > '9') && (c < 'a' || c > 'f') && (c < 'A' || c > 'F') {
                return false
            }
        }
    }
    return true
}

func validIPAddress(ip string) bool {
    if strings.Count(ip, ".") == 3 && validateIPV4(ip) {
        return true
    }
    if strings.Count(ip, ":") == 7 && validateIPV6(ip) {
        return true
    }
    return false
}