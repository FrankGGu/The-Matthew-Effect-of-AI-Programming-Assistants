func modifiedMatrix(matrix [][]int) [][]int {
	m := len(matrix)
	n := len(matrix[0])

	colMaxs := make([]int, n)
	for j := 0; j < n; j++ {
		colMaxs[j]