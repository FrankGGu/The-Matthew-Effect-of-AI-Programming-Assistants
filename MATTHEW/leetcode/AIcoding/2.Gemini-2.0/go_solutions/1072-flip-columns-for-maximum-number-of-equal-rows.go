func maxEqualRowsAfterFlips(matrix [][]int) int {
	count := make(map[string]int)
	for _, row := range matrix {
		s := ""
		flip := row[0]
		for _, val := range row {
			if val == flip {
				s += "0"
			} else {
				s += "1"
			}
		}
		count[s]++
	}

	maxCount := 0
	for _, c := range count {
		if c > maxCount {
			maxCount = c
		}
	}

	return maxCount
}