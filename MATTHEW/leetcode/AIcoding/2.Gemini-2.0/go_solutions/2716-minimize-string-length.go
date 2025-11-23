func minimizedStringLength(s string) int {
	seen := make(map[rune]bool)
	for _, r := range s {
		seen[r] = true
	}
	return len(seen)
}