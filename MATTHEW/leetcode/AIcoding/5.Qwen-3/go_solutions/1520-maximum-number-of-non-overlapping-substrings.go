package main

func maxNumOfNonOverlappingSubstrings(s string) int {
    dp := make([]int, len(s)+1)
    for i := 0; i < len(s); i++ {
        for j := i + 1; j <= len(s); j++ {
            if isSubstring(s[i:j], s) {
                dp[j] = max(dp[j], dp[i]+1)
            }
        }
    }
    return dp[len(s)]
}

func isSubstring(sub string, s string) bool {
    for i := 0; i <= len(s)-len(sub); i++ {
        match := true
        for j := 0; j < len(sub); j++ {
            if s[i+j] != sub[j] {
                match = false
                break
            }
        }
        if match {
            return true
        }
    }
    return false
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}