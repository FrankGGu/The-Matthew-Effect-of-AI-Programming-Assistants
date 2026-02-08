func decodeAtIndex(s string, k int) string {
    size := 0
    for _, c := range s {
        if c >= '0' && c <= '9' {
            size *= int(c - '0')
        } else {
            size++
        }
    }
    for i := len(s) - 1; i >= 0; i-- {
        c := s[i]
        k %= size
        if k == 0 && (c < '0' || c > '9') {
            return string(c)
        }
        if c >= '0' && c <= '9' {
            size /= int(c - '0')
        } else {
            size--
        }
    }
    return ""
}