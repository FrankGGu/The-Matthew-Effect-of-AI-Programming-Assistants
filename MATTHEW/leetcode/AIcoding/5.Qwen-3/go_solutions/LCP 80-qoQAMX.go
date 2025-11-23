package main

func numEnclaves(S [][]int) int {
	if len(S) == 0 || len(S[0]) == 0 {
		return 0
	}

	rows, cols := len(S), len(S[0])

	// 将边界的1及其相连的1变为0
	var dfs func(i, j int)
	dfs = func(i, j int) {
		if i < 0 || i >= rows || j < 0 || j >= cols || S[i][j] == 0 {
			return
		}
		S[i][j] = 0
		dfs(i+1, j)
		dfs(i-1, j)
		dfs(i, j+1)
		dfs(i, j-1)
	}

	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			if (i == 0 || i == rows-1 || j == 0 || j == cols-1) && S[i][j] == 1 {
				dfs(i, j)
			}
		}
	}

	// 统计剩余的1的数量
	count := 0
	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			if S[i][j] == 1 {
				count++
			}
		}
	}

	return count
}