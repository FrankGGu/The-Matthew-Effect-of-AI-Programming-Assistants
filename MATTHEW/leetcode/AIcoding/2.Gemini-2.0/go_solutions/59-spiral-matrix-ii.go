func generateMatrix(n int) [][]int {
	matrix := make([][]int, n)
	for i := range matrix {
		matrix[i] = make([]int, n)
	}

	num := 1
	top, bottom := 0, n-1
	left, right := 0, n-1

	for num <= n*n {
		for i := left; i <= right; i++ {
			matrix[top][i] = num
			num++
		}
		top++

		for i := top; i <= bottom; i++ {
			matrix[i][right] = num
			num++
		}
		right--

		if top <= bottom {
			for i := right; i >= left; i-- {
				matrix[bottom][i] = num
				num++
			}
			bottom--
		}

		if left <= right {
			for i := bottom; i >= top; i-- {
				matrix[i][left] = num
				num++
			}
			left++
		}
	}

	return matrix
}