package main

func countBinarySubstrings(s string) int {
    prev := 0
    curr := 1
    count := 0
    for i := 1; i < len(s); i++ {
        if s[i] == s[i-1] {
            curr++
        } else {
            count += min(prev, curr)
            prev, curr = curr, 1
        }
    }
    count += min(prev, curr)
    return count
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}