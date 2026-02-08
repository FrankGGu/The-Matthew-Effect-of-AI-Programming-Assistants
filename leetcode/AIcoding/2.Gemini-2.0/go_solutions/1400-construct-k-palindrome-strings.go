func canConstruct(s string, k int) bool {
	if k > len(s) {
		return false
	}

	counts := make(map[rune]int)
	for _, r := range s {
		counts[r]++
	}

	oddCount := 0
	for _, count := range counts {
		if count%2 != 0 {
			oddCount++
		}
	}

	return oddCount <= k
}