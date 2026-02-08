func minimumRecolors(blocks string, k int) int {
	n := len(blocks)
	whites := 0
	for i := 0; i < k; i++ {
		if blocks[i] == 'W' {
			whites++
		}
	}
	minWhites := whites
	for i := k; i < n; i++ {
		if blocks[i] == 'W' {
			whites++
		}
		if blocks[i-k] == 'W' {
			whites--
		}
		if whites < minWhites {
			minWhites = whites
		}
	}
	return minWhites
}