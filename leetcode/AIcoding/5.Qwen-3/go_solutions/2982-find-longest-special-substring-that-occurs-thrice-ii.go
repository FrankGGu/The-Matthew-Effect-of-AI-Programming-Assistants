package main

func maximumLength(s string) int {
    n := len(s)
    maxLen := -1
    for l := 1; l <= n; l++ {
        count := make(map[string]int)
        for i := 0; i <= n-l; i++ {
            substr := s[i : i+l]
            if isSpecial(substr) {
                count[substr]++
            }
        }
        for _, v := range count {
            if v >= 3 {
                maxLen = l
                break
            }
        }
        if maxLen != -1 {
            break
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