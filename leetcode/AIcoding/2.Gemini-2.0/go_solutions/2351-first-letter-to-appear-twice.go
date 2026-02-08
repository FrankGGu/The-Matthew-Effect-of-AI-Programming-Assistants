func repeatedCharacter(s string) byte {
	seen := make(map[rune]bool)
	for _, char := range s {
		if seen[char] {
			return byte(char)
		}
		seen[char] = true
	}
	return ' '
}