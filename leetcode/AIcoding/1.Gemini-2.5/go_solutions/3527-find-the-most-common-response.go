func mostCommonResponse(responses []string) string {
	if len(responses) == 0 {
		return ""
	}

	counts := make(map[string]int)
	for _, resp := range responses {
		counts[resp]++
	}

	maxCount := 0
	mostCommon := ""

	for resp, count := range counts {
		if count > maxCount {
			maxCount = count
			mostCommon = resp
		} else if count == maxCount {
			// If counts are equal, choose the lexicographically smallest response
			if mostCommon == "" || strings.Compare(resp, mostCommon) < 0 {
				mostCommon = resp
			}
		}
	}

	return mostCommon
}