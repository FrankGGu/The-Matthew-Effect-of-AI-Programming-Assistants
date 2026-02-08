import "sort"

func minimumLengthEncoding(words []string) int {
	sort.Slice(words, func(i, j int) bool {
		return len(words[i]) > len(words[j])
	})

	s := ""
	for _, word := range words {
		if !contains(s, word) {
			s += word + "#"
		}
	}

	return len(s)
}

func contains(s, word string) bool {
	for i := 0; i+len(word)+1 <= len(s); i++ {
		if s[i:i+len(word)] == word && s[i+len(word)] == '#' {
			return true
		}
	}
	return false
}