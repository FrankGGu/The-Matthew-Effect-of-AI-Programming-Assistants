func longestContinuousSubstring(s string) int {
    maxLen := 1
    currentLen := 1
    for i := 1; i < len(s); i++ {
        if s[i] == s[i-1]+1 {
            currentLen++
            if currentLen > maxLen {
                maxLen = currentLen
            }
        } else {
            currentLen = 1
        }
    }
    return maxLen
}