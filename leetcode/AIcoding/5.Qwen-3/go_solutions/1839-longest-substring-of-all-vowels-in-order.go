package main

func longestBeautifulSubstring(s string) int {
    maxLen := 0
    n := len(s)
    for i := 0; i < n; i++ {
        if s[i] != 'a' {
            continue
        }
        j := i + 1
        prev := 'a'
        currentLen := 1
        for j < n {
            curr := s[j]
            if curr >= prev {
                currentLen++
                prev = curr
            } else {
                break
            }
            j++
        }
        if currentLen > maxLen {
            maxLen = currentLen
        }
    }
    return maxLen
}