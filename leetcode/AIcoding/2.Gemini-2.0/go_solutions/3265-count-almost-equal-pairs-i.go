func countAlmostEqualPairs(words []string) int {
	n := len(words)
	count := 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			diff := 0
			for k := 0; k < len(words[i]); k++ {
				if words[i][k] != words[j][k] {
					diff++
				}
			}
			if diff <= 2 {
				count++
			}
		}
	}
	return count
}