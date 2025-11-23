func leastBricks(wall [][]int) int {
	gapFrequencies := make(map[int]int)
	maxFreq := 0

	for _, row := range wall {
		currentPos := 0
		for i := 0; i < len(row)-1; i++ {
			currentPos += row[i]
			gapFrequencies[currentPos]++
			if gapFrequencies[currentPos] > maxFreq {
				maxFreq = gapFrequencies[currentPos]
			}
		}
	}

	return len(wall) - maxFreq
}