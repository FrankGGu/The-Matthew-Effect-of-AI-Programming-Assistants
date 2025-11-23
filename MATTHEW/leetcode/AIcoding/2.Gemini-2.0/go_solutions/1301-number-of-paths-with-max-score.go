func pathsWithMaxScore(board []string) []int {
	n := len(board)
	dp := make([][][2]int, n)
	for i := range dp {
		dp[i] = make([][2]int, n)
	}

	dp[n-1][n-1] = [2]int{0, 1}

	for i := n - 1; i >= 0; i-- {
		for j := n - 1; j >= 0; j-- {
			if board[i][j] == 'X' {
				continue
			}
			if i == n-1 && j == n-1 {
				continue
			}

			maxScore := -1
			totalPaths := 0
			if i+1 < n && board[i+1][j] != 'X' {
				if dp[i+1][j][0] > maxScore {
					maxScore = dp[i+1][j][0]
					totalPaths = dp[i+1][j][1]
				} else if dp[i+1][j][0] == maxScore {
					totalPaths = (totalPaths + dp[i+1][j][1]) % (1e9 + 7)
				}
			}

			if i < n && j+1 < n && board[i][j+1] != 'X' {
				if dp[i][j+1][0] > maxScore {
					maxScore = dp[i][j+1][0]
					totalPaths = dp[i][j+1][1]
				} else if dp[i][j+1][0] == maxScore {
					totalPaths = (totalPaths + dp[i][j+1][1]) % (1e9 + 7)
				}
			}

			if i+1 < n && j+1 < n && board[i+1][j+1] != 'X' {
				if dp[i+1][j+1][0] > maxScore {
					maxScore = dp[i+1][j+1][0]
					totalPaths = dp[i+1][j+1][1]
				} else if dp[i+1][j+1][0] == maxScore {
					totalPaths = (totalPaths + dp[i+1][j+1][1]) % (1e9 + 7)
				}
			}

			if maxScore != -1 {
				val := 0
				if board[i][j] != 'E' {
					val = int(board[i][j] - '0')
				}
				dp[i][j][0] = maxScore + val
				dp[i][j][1] = totalPaths
			}
		}
	}

	if dp[0][0][1] == 0 {
		return []int{0, 0}
	}

	return []int{dp[0][0][0], dp[0][0][1]}
}