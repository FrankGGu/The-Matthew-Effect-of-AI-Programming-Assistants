func maskPII(s string) string {
    at := strings.Index(s, "@")
    if at != -1 {
        s = strings.ToLower(s)
        masked := string(s[0]) + "*****" + string(s[at-1])
        return masked + s[at:]
    }

    digits := make([]rune, 0)
    for _, c := range s {
        if c >= '0' && c <= '9' {
            digits = append(digits, c)
        }
    }
    n := len(digits)
    local := "***-***-" + string(digits[n-4:])
    if n == 10 {
        return local
    }
    res := "+"
    for i := 0; i < n-10; i++ {
        res += "*"
    }
    res += "-" + local
    return res
}