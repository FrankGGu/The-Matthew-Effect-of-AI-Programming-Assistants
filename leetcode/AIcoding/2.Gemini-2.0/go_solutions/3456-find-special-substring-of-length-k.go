func findSpecialSubstring(s string, k int) int {
	n := len(s)
	count := 0
	for i := 0; i <= n-k; i++ {
		sub := s[i : i+k]
		freq := make(map[rune]int)
		distinct := 0
		for _, r := range sub {
			if _, ok := freq[r]; !ok {
				distinct++
			}
			freq[r]++
		}
		if distinct == k-1 {
			count++
		}
	}
	return count
}