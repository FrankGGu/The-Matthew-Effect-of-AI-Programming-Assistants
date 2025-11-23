func longestContinuousSubstring(s string) int {
    maxLen := 1
    currentLen := 1

    for i := 1; i < len(s); i++ {
        if s[i] == s[i-1]+1 {
            currentLen++
        } else {
            if currentLen > maxLen {
                maxLen = currentLen
            }
            currentLen = 1
        }
    }

    if currentLen > maxLen {
        maxLen = currentLen
    }

    return maxLen
}