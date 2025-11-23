func matrixBlockSum(mat [][]int, k int) [][]int {
	m := len(mat)
	n := len(mat[0])

	// Create a 2D prefix sum array (integral image)
	// P[r][c] stores the sum of all