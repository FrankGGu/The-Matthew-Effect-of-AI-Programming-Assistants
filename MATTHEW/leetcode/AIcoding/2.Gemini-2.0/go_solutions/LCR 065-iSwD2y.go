import "sort"

func minimumLengthEncoding(words []string) int {
	sort.Slice(words, func(i, j int) bool {
		return len(words[i]) > len(words[j])
	})

	s := ""
	for _, w := range words {
		if !contains(s, w) {
			s += w + "#"
		}
	}
	return len(s)
}

func contains(s, w string) bool {
	for i := 0; i+len(w)+1 <= len(s); i++ {
		if s[i:i+len(w)] == w && s[i+len(w):i+len(w)+1] == '#' {
			return true
		}
	}
	return false
}