package main

func matchReplacement(s string, t string, m int, n int) bool {
    if len(t) > len(s) {
        return false
    }
    for i := 0; i <= len(s)-len(t); i++ {
        valid := true
        for j := 0; j < len(t); j++ {
            if s[i+j] != t[j] && (m == 0 || n == 0) {
                valid = false
                break
            }
        }
        if valid {
            return true
        }
    }
    return false
}