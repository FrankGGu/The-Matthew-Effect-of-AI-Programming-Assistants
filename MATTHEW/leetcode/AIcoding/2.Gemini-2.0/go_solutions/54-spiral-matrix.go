func spiralOrder(matrix [][]int) []int {
	if len(matrix) == 0 {
		return []int{}
	}

	rows := len(matrix)
	cols := len(matrix[0])
	result := make([]int, 0, rows*cols)

	top := 0
	bottom := rows - 1
	left := 0
	right := cols - 1

	for top <= bottom && left <= right {
		for i := left; i <= right; i++ {
			result = append(result, matrix[top][i])
		}
		top++

		if top > bottom {
			break
		}

		for i := top; i <= bottom; i++ {
			result = append(result, matrix[i][right])
		}
		right--

		if left > right {
			break
		}

		for i := right; i >= left; i-- {
			result = append(result, matrix[bottom][i])
		}
		bottom--

		if top > bottom {
			break
		}

		for i := bottom; i >= top; i-- {
			result = append(result, matrix[i][left])
		}
		left++
	}

	return result
}