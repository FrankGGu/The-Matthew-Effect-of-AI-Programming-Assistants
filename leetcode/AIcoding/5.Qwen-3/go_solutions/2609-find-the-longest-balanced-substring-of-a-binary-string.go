package main

func longestBalancedSubstring(s string) int {
    maxLen := 0
    count := 0
    for i := 0; i < len(s); i++ {
        if s[i] == '0' {
            count++
        } else {
            count--
        }
        if count == 0 {
            maxLen = max(maxLen, i+1)
        } else if count < 0 {
            count = 0
        }
    }
    count = 0
    for i := len(s) - 1; i >= 0; i-- {
        if s[i] == '0' {
            count++
        } else {
            count--
        }
        if count == 0 {
            maxLen = max(maxLen, len(s)-i)
        } else if count < 0 {
            count = 0
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