func myAtoi(s string) int {
    n := len(s)
    i := 0
    for i < n && s[i] == ' ' {
        i++
    }

    sign := 1
    if i < n && (s[i] == '-' || s[i] == '+') {
        if s[i] == '-' {
            sign = -1
        }
        i++
    }

    result := 0
    for i < n && s[i] >= '0' && s[i] <= '9' {
        digit := int(s[i] - '0')
        if result > (math.MaxInt32-digit)/10 {
            if sign == 1 {
                return math.MaxInt32
            }
            return math.MinInt32
        }
        result = result*10 + digit
        i++
    }

    return result * sign
}