package main

func maximumLength(s string) int {
    count := make(map[string]int)
    n := len(s)
    for i := 0; i < n; i++ {
        for j := i + 1; j <= n; j++ {
            substr := s[i:j]
            if isSpecial(substr) {
                count[substr]++
            }
        }
    }
    maxLen := -1
    for key, val := range count {
        if val >= 3 {
            maxLen = max(maxLen, len(key))
        }
    }
    return maxLen
}

func isSpecial(s string) bool {
    for i := 1; i < len(s); i++ {
        if s[i] != s[i-1] {
            return false
        }
    }
    return true
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}