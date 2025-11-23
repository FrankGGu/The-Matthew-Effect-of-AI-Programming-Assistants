func longestNiceSubstring(s string) string {
    maxPos, maxLen := 0, 0
    for i := 0; i < len(s); i++ {
        lower, upper := 0, 0
        for j := i; j < len(s); j++ {
            if s[j] >= 'a' && s[j] <= 'z' {
                lower |= 1 << (s[j] - 'a')
            } else {
                upper |= 1 << (s[j] - 'A')
            }
            if lower == upper && j - i + 1 > maxLen {
                maxPos, maxLen = i, j - i + 1
            }
        }
    }
    return s[maxPos : maxPos+maxLen]
}