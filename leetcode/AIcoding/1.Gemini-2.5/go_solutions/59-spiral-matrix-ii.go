func generateMatrix(n int) [][]int {
	matrix := make([][]int, n)
	for i := range matrix {
		matrix[i] = make([]int, n)
	}

	num := 1
	top, bottom := 0, n-1
	left, right := 0, n-1

	for num <= n*n {
		// Traverse right
		for c := left; c <= right; c++ {
			matrix[top][c] = num
			num++
		}
		top++

		// Traverse down
		for r := top; r <= bottom; r++ {
			matrix[r][right] = num
			num++
		}
		right--

		// Traverse left
		if top <= bottom {
			for c := right; c >= left; c-- {
				matrix[bottom][c] = num
				num++
			}
			bottom--
		}

		// Traverse up
		if left <= right {
			for r := bottom; r >= top; r-- {
				matrix[r][left] = num
				num++
			}
			left++
		}
	}

	return matrix
}