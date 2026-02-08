package main

func isNumber(s string) bool {
    s = strings.TrimSpace(s)
    if len(s) == 0 {
        return false
    }
    var dot, e, sign, num bool
    for i, c := range s {
        if c == '+' || c == '-' {
            if sign || num || i > 0 && s[i-1] != 'e' && s[i-1] != 'E' {
                return false
            }
            sign = true
        } else if c == '.' {
            if dot || e {
                return false
            }
            dot = true
        } else if c == 'e' || c == 'E' {
            if e || !num {
                return false
            }
            e = true
            sign = false
            num = false
        } else if c < '0' || c > '9' {
            return false
        } else {
            num = true
        }
    }
    return num
}