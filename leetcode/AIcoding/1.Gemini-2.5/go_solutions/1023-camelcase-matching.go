func camelMatch(queries []string, pattern string) []bool {
    result := make([]bool, len(queries))
    for i, query := range queries {
        result[i] = matches(query, pattern)
    }
    return result
}

func matches(query, pattern string) bool {
    qIdx := 0