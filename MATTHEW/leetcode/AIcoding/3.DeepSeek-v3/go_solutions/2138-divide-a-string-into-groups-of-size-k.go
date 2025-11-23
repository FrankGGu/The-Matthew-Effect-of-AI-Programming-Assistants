func divideString(s string, k int, fill byte) []string {
    var res []string
    n := len(s)
    for i := 0; i < n; i += k {
        end := i + k
        if end > n {
            end = n
        }
        group := s[i:end]
        if len(group) < k {
            for len(group) < k {
                group += string(fill)
            }
        }
        res = append(res, group)
    }
    return res
}