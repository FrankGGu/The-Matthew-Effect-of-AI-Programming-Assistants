func numSubmatrixSumTarget(matrix [][]int, target int) int {
	n := len(matrix)
	m := len(matrix[0])
	count := 0

	for i := 0; i < n; i++ {
		for j := 1; j < m; j++ {
			matrix[i][j] += matrix[i][j-1]
		}
	}

	for c1 := 0; c1 < m; c1++ {
		for c2 := c1; c2 < m; c2++ {
			prefixSums := make(map[int]int)
			prefixSums[0] = 1
			currSum := 0

			for row := 0; row < n; row++ {
				sum := 0
				if c1 > 0 {
					sum = matrix[row][c2] - matrix[row][c1-1]
				} else {
					sum = matrix[row][c2]
				}

				currSum += sum

				if val, ok := prefixSums[currSum-target]; ok {
					count += val
				}

				prefixSums[currSum]++
			}
		}
	}

	return count
}