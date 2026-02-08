func zigzagTraverseWithSkip(matrix [][]int, skip int) []int {
	if len(matrix) == 0 {
		return []int{}
	}

	m, n := len(matrix), len(matrix[0])
	result := make([]int, 0)
	row, col := 0, 0
	up := true

	for len(result) < m*n {
		result = append(result, matrix[row][col])

		if up {
			if row-1 >= 0 && col+1 < n && len(result)%skip != 0 {
				row--
				col++
			} else {
				if col+1 < n {
					col++
				} else {
					row++
				}
				up = false
			}
		} else {
			if row+1 < m && col-1 >= 0 && len(result)%skip != 0 {
				row++
				col--
			} else {
				if row+1 < m {
					row++
				} else {
					col++
				}
				up = true
			}
		}
	}

	return result
}