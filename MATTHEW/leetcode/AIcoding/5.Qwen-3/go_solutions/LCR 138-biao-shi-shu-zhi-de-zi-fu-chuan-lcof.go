package main

func isNumber(s string) bool {
    if len(s) == 0 {
        return false
    }

    // 移除首尾空格
    s = strings.TrimSpace(s)
    if len(s) == 0 {
        return false
    }

    // 检查是否包含e或E
    hasE := false
    eIndex := -1
    for i, c := range s {
        if c == 'e' || c == 'E' {
            if hasE {
                return false
            }
            hasE = true
            eIndex = i
        }
    }

    if hasE {
        if eIndex == 0 || eIndex == len(s)-1 {
            return false
        }
        left := s[:eIndex]
        right := s[eIndex+1:]
        return isInteger(left) || isDecimal(left) && isInteger(right)
    } else {
        return isInteger(s) || isDecimal(s)
    }
}

func isInteger(s string) bool {
    if len(s) == 0 {
        return false
    }
    if s[0] == '+' || s[0] == '-' {
        s = s[1:]
    }
    if len(s) == 0 {
        return false
    }
    for _, c := range s {
        if c < '0' || c > '9' {
            return false
        }
    }
    return true
}

func isDecimal(s string) bool {
    if len(s) == 0 {
        return false
    }
    if s[0] == '+' || s[0] == '-' {
        s = s[1:]
    }
    if len(s) == 0 {
        return false
    }
    dotCount := 0
    for _, c := range s {
        if c == '.' {
            dotCount++
            if dotCount > 1 {
                return false
            }
        } else if c < '0' || c > '9' {
            return false
        }
    }
    return dotCount == 1
}