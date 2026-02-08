func uniqueLetterString(s string) int {
    last := make([]int, 26)
    result := 0
    n := len(s)

    for i := 0; i < n; i++ {
        charIndex := s[i] - 'A'
        result += (i + 1) * (n - i) - (i - last[charIndex]) * (n - i - 1)
        last[charIndex] = i
    }

    return result
}