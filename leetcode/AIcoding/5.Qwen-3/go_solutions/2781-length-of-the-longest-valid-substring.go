package main

func longestValidSubstring(s string) int {
    maxLen := 0
    lastOccurrence := make(map[rune]int)
    left := 0

    for right, char := range s {
        if prev, ok := lastOccurrence[char]; ok && prev >= left {
            left = prev + 1
        }
        lastOccurrence[char] = right
        maxLen = max(maxLen, right-left+1)
    }

    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}