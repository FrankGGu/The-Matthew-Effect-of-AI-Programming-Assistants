func shortestSequence(rolls []int, k int) int {
	seen := make(map[int]bool)
	count := 0
	for _, roll := range rolls {
		if _, ok := seen[roll]; !ok {
			seen[roll] = true
		}
		if len(seen) == k {
			count++
			seen = make(map[int]bool)
		}
	}
	return count + 1
}