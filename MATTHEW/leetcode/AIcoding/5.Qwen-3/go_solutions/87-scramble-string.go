package main

func isScramble(s1 string, s2 string) bool {
    if len(s1) != len(s2) {
        return false
    }
    if s1 == s2 {
        return true
    }
    if len(s1) == 1 {
        return false
    }
    key := s1 + "," + s2
    if val, ok := memo[key]; ok {
        return val
    }
    n := len(s1)
    for i := 1; i < n; i++ {
        if isScramble(s1[:i], s2[:i]) && isScramble(s1[i:], s2[i:]) {
            memo[key] = true
            return true
        }
        if isScramble(s1[:i], s2[n-i:]) && isScramble(s1[i:], s2[:n-i]) {
            memo[key] = true
            return true
        }
    }
    memo[key] = false
    return false
}

var memo = make(map[string]bool)