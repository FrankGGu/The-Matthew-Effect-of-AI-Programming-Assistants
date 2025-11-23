func myAtoi(s string) int {
    i := 0
    n := len(s)
    for i < n && s[i] == ' ' {
        i++
    }
    if i == n {
        return 0
    }

    sign := 1
    if s[i] == '-' {
        sign = -1
        i++
    } else if s[i] == '+' {
        i++
    }

    res := 0
    for i < n && s[i] >= '0' && s[i] <= '9' {
        digit := int(s[i] - '0')
        if res > (math.MaxInt32 - digit) / 10 {
            if sign == 1 {
                return math.MaxInt32
            } else {
                return math.MinInt32
            }
        }
        res = res * 10 + digit
        i++
    }

    return res * sign
}