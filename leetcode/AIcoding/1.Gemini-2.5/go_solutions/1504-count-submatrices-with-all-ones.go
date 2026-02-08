func numSubmat(mat [][]int) int {
	rows := len(mat)
	if rows == 0 {
		return 0
	}
	cols := len(mat[0])
	if cols == 0 {
		return 0
	}

	// dp[i][j] stores the number of consecutive ones ending