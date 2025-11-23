package main

func longestIncreasingPath(matrix [][]int) int {
	if len(matrix) == 0 || len(matrix[0]) == 0 {
		return 0
	}

	m := len(matrix)
	n := len(matrix[0])
	memo := make([][]int, m)
	for i := range memo {
		memo[i] = make([]int, n)
	}

	maxOverallPath := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			maxOverallPath = max(maxOverallPath, dfs(matrix, i, j, m, n, memo))
		}
	}

	return maxOverallPath
}

func dfs(matrix [][]int, r, c, m, n int, memo [][]int) int {
	if memo[r][c] != 0 {
		return memo[r][c]
	}

	maxPath := 1
	dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	for _, dir := range dirs {
		nr, nc := r+dir[0], c+dir[1]

		if nr >= 0 && nr < m && nc >= 0 && nc < n && matrix[nr][nc] > matrix[r][c] {
			maxPath = max(maxPath, 1+dfs(matrix, nr, nc, m, n, memo))
		}
	}

	memo[r][c] = maxPath
	return maxPath
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}