func spiralOrder(matrix [][]int) []int {
	if len(matrix) == 0 || len(matrix[0]) == 0 {
		return []int{}
	}

	rows := len(matrix)
	cols := len(matrix[0])
	result := make([]int, 0, rows*cols)

	top