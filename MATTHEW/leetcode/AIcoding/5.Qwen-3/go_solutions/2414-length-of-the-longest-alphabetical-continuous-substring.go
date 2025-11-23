package main

func longestAlphabeticalSubstring(s string) int {
    if s == "" {
        return 0
    }
    maxLen := 1
    currentLen := 1
    for i := 1; i < len(s); i++ {
        if s[i] > s[i-1] {
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