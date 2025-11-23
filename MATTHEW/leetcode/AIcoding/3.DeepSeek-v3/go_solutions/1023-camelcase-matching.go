func camelMatch(queries []string, pattern string) []bool {
    res := make([]bool, len(queries))
    for i, query := range queries {
        res[i] = isMatch(query, pattern)
    }
    return res
}

func isMatch(query, pattern string) bool {
    j := 0
    for i := 0; i < len(query); i++ {
        if j < len(pattern) && query[i] == pattern[j] {
            j++
        } else if query[i] >= 'A' && query[i] <= 'Z' {
            return false
        }
    }
    return j == len(pattern)
}