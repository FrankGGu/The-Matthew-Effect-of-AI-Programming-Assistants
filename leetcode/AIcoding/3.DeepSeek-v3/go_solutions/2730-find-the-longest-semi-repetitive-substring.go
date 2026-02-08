func longestSemiRepetitiveSubstring(s string) int {
    maxLen := 1
    n := len(s)
    for i := 0; i < n; i++ {
        cnt := 0
        for j := i + 1; j < n; j++ {
            if s[j] == s[j-1] {
                cnt++
            }
            if cnt > 1 {
                break
            }
            if j - i + 1 > maxLen {
                maxLen = j - i + 1
            }
        }
    }
    return maxLen
}