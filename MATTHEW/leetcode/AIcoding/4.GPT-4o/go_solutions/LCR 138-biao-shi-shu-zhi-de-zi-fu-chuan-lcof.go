func isNumber(s string) bool {
    s = strings.TrimSpace(s)
    if len(s) == 0 {
        return false
    }

    numSeen, dotSeen, eSeen := false, false, false
    for i, ch := range s {
        if ch >= '0' && ch <= '9' {
            numSeen = true
        } else if ch == '.' {
            if dotSeen || eSeen {
                return false
            }
            dotSeen = true
        } else if ch == 'e' || ch == 'E' {
            if eSeen || !numSeen {
                return false
            }
            eSeen = true
            numSeen = false
            if i+1 < len(s) && (s[i+1] == '+' || s[i+1] == '-') {
                i++
            }
        } else if ch == '+' || ch == '-' {
            if i > 0 && s[i-1] != 'e' && s[i-1] != 'E' {
                return false
            }
        } else {
            return false
        }
    }
    return numSeen
}