func appealSum(s string) int64 {
    lastIndex := make([]int, 26)
    totalAppeal := int64(0)
    n := len(s)

    for i := 0; i < n; i++ {
        charIndex := s[i] - 'a'
        lastIndex[charIndex] = i + 1
        for j := 0; j < 26; j++ {
            totalAppeal += int64(lastIndex[j])
        }
    }

    return totalAppeal
}