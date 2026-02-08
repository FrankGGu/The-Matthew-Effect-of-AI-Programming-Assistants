func divideString(s string, k int, fill byte) []string {
    n := len(s)
    res := []string{}
    for i := 0; i < n; i += k {
        sub := s[i:min(i+k, n)]
        if len(sub) < k {
            for j := len(sub); j < k; j++ {
                sub += string(fill)
            }
        }
        res = append(res, sub)
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}