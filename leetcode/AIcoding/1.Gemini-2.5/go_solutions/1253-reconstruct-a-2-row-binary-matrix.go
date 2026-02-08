func reconstructMatrix(upper int, lower int, colsum []int) [][]int {
	n := len(colsum)
	ans := make([][]int, 2)
	ans[0] = make([]int, n)
	ans[1] = make([]int, n)

	// Calculate total sum of col