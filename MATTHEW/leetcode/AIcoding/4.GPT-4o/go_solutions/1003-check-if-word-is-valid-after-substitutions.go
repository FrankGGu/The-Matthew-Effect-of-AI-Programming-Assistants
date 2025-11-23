func checkValidString(s string) bool {
    balance := 0
    for _, ch := range s {
        if ch == '(' {
            balance++
        } else if ch == ')' {
            balance--
        }
        if balance < 0 {
            return false
        }
    }
    balance = 0
    for i := len(s) - 1; i >= 0; i-- {
        ch := s[i]
        if ch == ')' {
            balance++
        } else if ch == '(' {
            balance--
        }
        if balance < 0 {
            return false
        }
    }
    return true
}