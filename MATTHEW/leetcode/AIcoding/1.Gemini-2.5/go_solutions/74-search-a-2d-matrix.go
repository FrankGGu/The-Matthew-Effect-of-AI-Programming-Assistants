func searchMatrix(matrix [][]int, target int) bool {
	if len(matrix) == 0 || len(matrix[0]) == 0 {
		return false
	}

	m := len(matrix)
	n := len(matrix[0])

	low := 0
	high := m*n - 1

	for low <= high {
		mid := low + (high-low)/2

		row := mid / n
		col := mid % n

		val := matrix[row][col]

		if val == target {
			return true
		} else if val < target {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}

	return false
}