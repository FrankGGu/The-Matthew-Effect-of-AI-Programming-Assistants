func sampleStats(count []int) []float64 {
	minVal := -1
	maxVal := -1
	totalCount := 0
	sum := 0.0
	maxFreq := -1
	modeVal := -1

	// Calculate min, max, sum, totalCount, and mode
	for