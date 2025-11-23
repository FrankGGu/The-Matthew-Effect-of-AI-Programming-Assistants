func isPrefixString(s string, words []string) bool {
	currentPrefix := ""
	for _, word := range words {
		currentPrefix += word

		if len(currentPrefix) > len(s) {
			return false
		}

		if currentPrefix != s[:len(currentPrefix)] {
			return false