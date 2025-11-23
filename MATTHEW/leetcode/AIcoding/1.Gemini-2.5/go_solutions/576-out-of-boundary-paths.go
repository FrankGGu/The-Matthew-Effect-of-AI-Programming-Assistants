package main

const MOD int = 1e9 + 7

func findPaths(m int, n int, maxMove int, startRow int, startColumn int) int {
	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	dp[startRow][startColumn] = 1
	ans := 0

	dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	for move := 1; move <= maxMove; move++ {
		newDp := make([][]int, m)
		for i := range newDp {
			newDp[i] = make([]int, n)
		}

		for r := 0; r < m; r++ {
			for c := 0; c < n; c++ {
				if dp[r][c] > 0 {
					for _, dir := range dirs {
						nr, nc := r+dir[0], c+dir[1]
						if nr < 0 || nr >= m || nc < 0 || nc >= n {
							ans = (ans + dp[r][c]) % MOD
						} else {
							newDp[nr][nc] = (newDp[nr][nc] + dp[r][c]) % MOD
						}
					}
				}
			}
		}
		dp = newDp
	}

	return ans
}