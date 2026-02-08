func mostCommon(responses []string) string {
	counts := make(map[string]int)
	for _, r := range responses {
		counts[r]++
	}

	var mostCommonResponse string
	maxCount := 0
	for r, count := range counts {
		if count > maxCount {
			mostCommonResponse = r
			maxCount = count
		}
	}

	return mostCommonResponse
}