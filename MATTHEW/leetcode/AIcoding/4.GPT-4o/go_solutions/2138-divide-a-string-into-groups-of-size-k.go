func divideString(s string, k int, fill byte) []string {
    n := len(s)
    var result []string

    for i := 0; i < n; i += k {
        end := i + k
        if end > n {
            end = n
            for end < i+k {
                s += string(fill)
                end++
            }
        }
        result = append(result, s[i:end])
    }

    return result
}