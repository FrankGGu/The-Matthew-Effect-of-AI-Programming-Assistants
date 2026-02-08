func expressiveWords(s string, words []string) int {
	res := 0
	for _, word := range words {
		if isStretchy(s, word) {
			res++
		}
	}
	return res
}

func isStretchy(s, word string) bool {