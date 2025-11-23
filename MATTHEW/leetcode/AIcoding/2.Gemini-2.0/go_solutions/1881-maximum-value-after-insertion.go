func maxValue(n string, x int) string {
    res := ""
    inserted := false
    if n[0] == '-' {
        res += "-"
        for i := 1; i < len(n); i++ {
            digit := int(n[i] - '0')
            if !inserted && digit > x {
                res += string(rune(x + '0'))
                inserted = true
            }
            res += string(n[i])
        }
        if !inserted {
            res += string(rune(x + '0'))
        }
    } else {
        for i := 0; i < len(n); i++ {
            digit := int(n[i] - '0')
            if !inserted && digit < x {
                res += string(rune(x + '0'))
                inserted = true
            }
            res += string(n[i])
        }
        if !inserted {
            res += string(rune(x + '0'))
        }
    }
    return res
}