func solve(names []string) map[string]int {
	counts := make(map[string]int)
	for _, name := range names {
		counts[name]++
	}
	return counts
}