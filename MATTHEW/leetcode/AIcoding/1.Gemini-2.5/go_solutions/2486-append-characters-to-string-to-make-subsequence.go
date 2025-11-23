func appendCharacters(s string, t string) int {
	i := 0 // Pointer for string s
	j := 0 // Pointer for string t

	for i < len(s) && j < len(t) {
		if s[i] == t[j] {
			j++ // Found a character of