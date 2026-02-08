func rowAndMaximumOnes(mat [][]int) []int {
	maxOnesCount := 0
	maxOnesRowIndex := 0

	for i := 0; i < len(mat); i++ {
		currentOnesCount := 0
		for j := 0; j < len(mat[i]); j++ {
			if mat[i][j] == 1 {
				currentOnesCount++
			}
		}

		if currentOnesCount > maxOnesCount {
			maxOnesCount = currentOnesCount
			maxOnesRowIndex = i
		}
	}

	return []int{maxOnesRowIndex, maxOnesCount}
}