func canBeValid(s string, locked string) bool {
    if len(s)%2 != 0 {
        return false
    }

    n := len(s)
    bal := 0
    wild := 0

    for i := 0; i < n; i++ {
        if locked[i] == '1' {
            if s[i] == '(' {
                bal++
            } else {
                bal--
            }
        } else {
            wild++
        }

        if bal+wild < 0 {
            return false
        }
    }

    bal = 0
    wild = 0

    for i := n - 1; i >= 0; i-- {
        if locked[i] == '1' {
            if s[i] == ')' {
                bal++
            } else {
                bal--
            }
        } else {
            wild++
        }

        if bal+wild < 0 {
            return false
        }
    }

    return true
}