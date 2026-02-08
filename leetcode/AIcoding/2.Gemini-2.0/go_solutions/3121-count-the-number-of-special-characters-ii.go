func countSpecialCharacters(s string) int {
	count := 0
	seen := make(map[rune]bool)
	for _, r := range s {
		if !((r >= 'a' && r <= 'z') || (r >= 'A' && r <= 'Z') || (r >= '0' && r <= '9')) {
			if !seen[r] {
				count++
				seen[r] = true
			}
		}
	}
	return count
}