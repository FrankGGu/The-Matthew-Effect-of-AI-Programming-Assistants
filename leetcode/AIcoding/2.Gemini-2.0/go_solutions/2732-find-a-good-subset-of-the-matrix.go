func goodSubsetofBinaryMatrix(matrix [][]int) []int {
	m := len(matrix)
	n := len(matrix[0])

	for i := 0; i < m; i++ {
		if allZeros(matrix[i]) {
			return []int{i}
		}
	}

	for i := 0; i < m; i++ {
		for j := i + 1; j < m; j++ {
			if isGoodPair(matrix[i], matrix[j]) {
				return []int{i, j}
			}
		}
	}

	return []int{}
}

func allZeros(row []int) bool {
	for _, val := range row {
		if val != 0 {
			return false
		}
	}
	return true
}

func isGoodPair(row1, row2 []int) bool {
	for i := range row1 {
		if row1[i] == 1 && row2[i] == 1 {
			return false
		}
	}
	return true
}