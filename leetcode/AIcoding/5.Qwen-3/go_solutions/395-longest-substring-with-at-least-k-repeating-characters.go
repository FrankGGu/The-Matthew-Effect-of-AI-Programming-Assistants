package main

func longestSubstring(s string, k int) int {
    if len(s) < k {
        return 0
    }
    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }
    for i, c := range s {
        if count[c] < k {
            left := longestSubstring(s[:i], k)
            right := longestSubstring(s[i+1:], k)
            if left > right {
                return left
            } else {
                return right
            }
        }
    }
    return len(s)
}