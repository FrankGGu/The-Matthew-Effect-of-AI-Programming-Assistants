func maxProductPath(grid [][]int) int {
	m, n := len(grid), len(grid[0])
	maxDP := make([][]int, m)
	minDP := make([][]int, m)
	for i := range maxDP {
		maxDP[i] = make([]int, n)
		minDP[i] = make([]int, n)
	}

	maxDP[0][0] = grid[0][0]
	minDP[0][0] = grid[0][0]

	for i := 1; i < m; i++ {
		maxDP[i][0] = maxDP[i-1][0] * grid[i][0]
		minDP[i][0] = minDP[i-1][0] * grid[i][0]
	}

	for j := 1; j < n; j++ {
		maxDP[0][j] = maxDP[0][j-1] * grid[0][j]
		minDP[0][j] = minDP[0][j-1] * grid[0][j]
	}

	for i := 1; i < m; i++ {
		for j := 1; j < n; j++ {
			maxDP[i][j] = max(maxDP[i-1][j]*grid[i][j], maxDP[i][j-1]*grid[i][j], minDP[i-1][j]*grid[i][j], minDP[i][j-1]*grid[i][j])
			minDP[i][j] = min(maxDP[i-1][j]*grid[i][j], maxDP[i][j-1]*grid[i][j], minDP[i-1][j]*grid[i][j], minDP[i][j-1]*grid[i][j])
		}
	}

	if maxDP[m-1][n-1] < 0 {
		return -1
	}

	return maxDP[m-1][n-1] % (1e9 + 7)
}

func max(nums ...int) int {
	res := nums[0]
	for _, num := range nums {
		if num > res {
			res = num
		}
	}
	return res
}

func min(nums ...int) int {
	res := nums[0]
	for _, num := range nums {
		if num < res {
			res = num
		}
	}
	return res
}