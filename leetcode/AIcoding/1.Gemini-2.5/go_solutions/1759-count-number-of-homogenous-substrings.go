func countHomogenous(s string) int {
	var totalCount int64 = 0
	var currentCount int64 = 0

	if len(s) == 0 {
		return 0
	}

	currentCount = 1
	for i := 1; i < len(s); i++ {
		if s[i] == s[i-1] {
			currentCount++
		} else {
			totalCount += currentCount * (currentCount + 1) / 2
			currentCount = 1
		}
	}

	totalCount += currentCount * (currentCount + 1) / 2

	return int(totalCount)
}