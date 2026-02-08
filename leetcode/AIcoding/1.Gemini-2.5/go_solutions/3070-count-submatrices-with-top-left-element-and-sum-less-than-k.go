func countSubmatrices(grid [][]int, k int) int {
	m := len(grid)
	n := len(grid[0])

	// Create a prefix sum array.
	// prefixSum[r+1][c+1] will store the sum of the submatrix from (0,0) to (r,c