func countSpecialCharacters(word string) int {
	count := 0
	seen := make(map[rune]bool)
	for _, r := range word {
		if !seen[r] {
			if (r >= 'a' && r <= 'z') || (r >= 'A' && r <= 'Z') || (r >= '0' && r <= '9') {
				seen[r] = true
			} else {
				count++
				seen[r] = true
			}
		}
	}
	return count
}