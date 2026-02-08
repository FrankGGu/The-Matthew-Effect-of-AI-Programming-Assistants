package main

func longestSemiRepetitiveSubstring(s string) int {
    n := len(s)
    maxLen := 0
    for i := 0; i < n; i++ {
        count := 0
        for j := i + 1; j < n; j++ {
            if s[j] == s[j-1] {
                count++
            }
            if count > 1 {
                break
            }
            maxLen = max(maxLen, j - i + 1)
        }
    }
    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}