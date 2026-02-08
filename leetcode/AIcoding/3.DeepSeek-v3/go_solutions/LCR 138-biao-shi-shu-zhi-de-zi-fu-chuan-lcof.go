func isNumber(s string) bool {
    s = strings.TrimSpace(s)
    if len(s) == 0 {
        return false
    }

    seenDigit := false
    seenDot := false
    seenE := false

    for i, ch := range s {
        if ch >= '0' && ch <= '9' {
            seenDigit = true
        } else if ch == '.' {
            if seenDot || seenE {
                return false
            }
            seenDot = true
        } else if ch == 'e' || ch == 'E' {
            if seenE || !seenDigit {
                return false
            }
            seenE = true
            seenDigit = false
        } else if ch == '+' || ch == '-' {
            if i != 0 && s[i-1] != 'e' && s[i-1] != 'E' {
                return false
            }
        } else {
            return false
        }
    }

    return seenDigit
}