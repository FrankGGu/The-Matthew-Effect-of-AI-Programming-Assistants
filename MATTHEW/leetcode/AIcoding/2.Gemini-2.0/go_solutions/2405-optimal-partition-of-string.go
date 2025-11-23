func partitionString(s string) int {
	count := 1
	seen := make(map[rune]bool)
	for _, char := range s {
		if seen[char] {
			count++
			seen = make(map[rune]bool)
		}
		seen[char] = true
	}
	return count
}