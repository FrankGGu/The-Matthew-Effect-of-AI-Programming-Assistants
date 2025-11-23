func splitWordsBySeparator(words []string, separator byte) []string {
	result := []string{}
	sepStr := string(separator)

	for _, word := range words {
		parts := strings.Split(word, sepStr)
		for _, part := range parts {
			if part != "" {
				result = append(result, part)
			}
		}
	}

	return result
}