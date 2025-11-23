func findDiagonalOrder(mat [][]int) []int {
	m := len(mat)
	n := len(mat[0])
	result := make([]int, m*n)
	row, col := 0, 0
	up := true
	for i := 0; i < m*n; i++ {
		result[i] = mat[row][col]
		if up {
			if row-1 >= 0 && col+1 < n {
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
			if row+1 < m && col-1 >= 0 {
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