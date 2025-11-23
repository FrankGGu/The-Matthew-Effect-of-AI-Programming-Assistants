func leastBricks(wall [][]int) int {
	freq := make(map[int]int)
	maxFreq := 0
	for _, row := range wall {
		sum := 0
		for i := 0; i < len(row)-1; i++ {
			sum += row[i]
			freq[sum]++
			if freq[sum] > maxFreq {
				maxFreq = freq[sum]
			}
		}
	}
	return len(wall) - maxFreq
}