func repeatedSubstringPattern(s string) bool {
    n := len(s)
    for l := 1; l <= n/2; l++ {
        if n % l != 0 {
            continue
        }
        pattern := s[:l]
        valid := true
        for i := l; i < n; i += l {
            if s[i:i+l] != pattern {
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