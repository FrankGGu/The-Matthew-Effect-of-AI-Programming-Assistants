func camelMatch(queries []string, pattern string) []bool {
    results := make([]bool, len(queries))
    for i, query := range queries {
        j, k := 0, 0
        match := true
        for j < len(query) && k < len(pattern) {
            if query[j] == pattern[k] {
                j++
                k++
            } else if query[j] >= 'A' && query[j] <= 'Z' {
                match = false
                break
            } else {
                j++
            }
        }
        for j < len(query) {
            if query[j] >= 'A' && query[j] <= 'Z' {
                match = false
                break
            }
            j++
        }
        if k < len(pattern) {
            match = false
        }
        results[i] = match
    }
    return results
}