func searchMatrix(matrix [][]int, target int) bool {
	if len(matrix) == 0 || len(matrix[0]) == 0 {
		return false
	}

	rows := len(matrix)
	cols := len(matrix[0])

	// Start from the top-right corner of the matrix
	row := 0
	col := cols - 1

	for row < rows && col >= 0 {
		currentVal := matrix[row][col]
		if currentVal == target {
			return true
		} else if currentVal < target {
			// If the current value is less than the target,
			// it means we need a larger value. Since the row is sorted
			// in ascending order from left to right, and columns are sorted
			// in ascending order from top to bottom, moving down to the
			// next row will give us larger values.
			row++
		} else {
			// If the current value is greater than the target,
			// it means we need a smaller value. Moving left in the
			// current row will give us smaller values.
			col--
		}
	}

	return false
}