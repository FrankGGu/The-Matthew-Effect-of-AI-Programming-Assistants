func setZeroes(matrix [][]int) {
	m := len(matrix)
	if m == 0 {
		return
	}
	n := len(matrix[0])
	if n == 0 {
		return
	}

	firstColHasZero := false
	for i := 0; i < m; i++ {
		if matrix[i][0] == 0 {
			firstColHasZero = true
			break
		}
	}

	firstRowHasZero := false
	for j := 0; j < n; j++ {
		if matrix[0][j] == 0 {
			firstRowHasZero = true
			break
		}
	}

	for i := 1; i < m; i++ {
		for j := 1; j < n; j++ {
			if matrix[i][j] == 0 {
				matrix[i][0] = 0
				matrix[0][j] = 0
			}
		}
	}

	for i := 1; i < m; i++ {
		if matrix[i][0] == 0 {
			for j := 1; j < n; j++ {
				matrix[i][j] = 0
			}
		}
	}

	for j := 1; j < n; j++ {
		if matrix[0][j] == 0 {
			for i := 1; i < m; i++ {
				matrix[i][j] = 0
			}
		}
	}

	if firstColHasZero {
		for i := 0; i < m; i++ {
			matrix[i][0] = 0
		}
	}

	if firstRowHasZero {
		for j := 0; j < n; j++ {
			matrix[0][j] = 0
		}
	}
}