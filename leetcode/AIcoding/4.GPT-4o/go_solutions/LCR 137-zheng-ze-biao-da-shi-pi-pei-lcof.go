func camelMatch(queries []string, pattern string) []bool {
    res := make([]bool, len(queries))
    for i, query := range queries {
        j, k := 0, 0
        for j < len(query) && k < len(pattern) {
            if query[j] == pattern[k] {
                j++
                k++
            } else if query[j] >= 'A' && query[j] <= 'Z' {
                break
            } else {
                j++
            }
        }
        if k < len(pattern) {
            res[i] = false
            continue
        }
        for ; j < len(query); j++ {
            if query[j] >= 'A' && query[j] <= 'Z' {
                res[i] = false
                break
            }
        }
        if j == len(query) {
            res[i] = true
        }
    }
    return res
}