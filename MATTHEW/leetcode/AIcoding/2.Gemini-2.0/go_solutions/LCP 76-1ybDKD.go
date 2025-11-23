import "fmt"

func solve() {
	var n, m int
	fmt.Scan(&n, &m)

	board := make([][]int, n)
	for i := 0; i < n; i++ {
		board[i] = make([]int, m)
		for j := 0; j < m; j++ {
			fmt.Scan(&board[i][j])
		}
	}

	dp := make([][]int, n)
	for i := 0; i < n; i++ {
		dp[i] = make([]int, m)
	}

	dp[0][0] = board[0][0]

	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			if i > 0 {
				dp[i][j] = max(dp[i][j], dp[i-1][j]+board[i][j])
			}
			if j > 0 {
				dp[i][j] = max(dp[i][j], dp[i][j-1]+board[i][j])
			}
		}
	}

	fmt.Println(dp[n-1][m-1])
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}