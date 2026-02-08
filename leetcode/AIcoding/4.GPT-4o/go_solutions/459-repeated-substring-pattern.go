func repeatedSubstringPattern(s string) bool {
    n := len(s)
    if n < 2 {
        return false
    }
    ss := s + s
    return ss[1:n*2-1].find(s) != -1
}