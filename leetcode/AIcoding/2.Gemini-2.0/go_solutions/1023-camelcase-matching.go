func camelMatch(queries []string, pattern string) []bool {
	result := make([]bool, len(queries))
	for i, query := range queries {
		result[i] = match(query, pattern)
	}
	return result
}

func match(query string, pattern string) bool {
	i, j := 0, 0
	for i < len(query) {
		if j < len(pattern) && query[i] == pattern[j] {
			i++
			j++
		} else if query[i] >= 'A' && query[i] <= 'Z' {
			return false
		} else {
			i++
		}
	}
	return j == len(pattern)
}