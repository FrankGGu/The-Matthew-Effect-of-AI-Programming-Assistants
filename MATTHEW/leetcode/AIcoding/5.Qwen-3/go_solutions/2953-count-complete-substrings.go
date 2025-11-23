package main

func countCompleteSubstrings(s string) int {
    result := 0
    for i := 0; i < len(s); i++ {
        for j := i + 1; j <= len(s); j++ {
            substr := s[i:j]
            if isComplete(substr) {
                result++
            }
        }
    }
    return result
}

func isComplete(s string) bool {
    if len(s) == 0 {
        return false
    }
    prev := s[0]
    for i := 1; i < len(s); i++ {
        if s[i] != prev+1 {
            return false
        }
        prev = s[i]
    }
    return true
}