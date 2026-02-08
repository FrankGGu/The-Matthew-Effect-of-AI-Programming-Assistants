func repeatedCharacter(s string) byte {
	seen := [26]bool{}
	for i := 0; i < len(s); i++ {
		charIndex := s[i] - 'a'
		if seen[charIndex] {
			return s[i]
		}
		seen[charIndex] = true
	}
	return ' ' // Should not be reached based on problem constraints
}