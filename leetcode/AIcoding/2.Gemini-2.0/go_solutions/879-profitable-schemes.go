func profitableSchemes(n int, minProfit int, group []int, profit []int) int {
	mod := 1000000007
	dp := make([][][]int, len(group)+1)
	for i := range dp {
		dp[i] = make([][]int, n+1)
		for j := range dp[i] {
			dp[i][j] = make([]int, minProfit+1)
		}
	}

	dp[0][0][0] = 1

	for i := 1; i <= len(group); i++ {
		g := group[i-1]
		p := profit[i-1]
		for j := 0; j <= n; j++ {
			for k := 0; k <= minProfit; k++ {
				dp[i][j][k] = dp[i-1][j][k]
				if j >= g {
					dp[i][j][k] = (dp[i][j][k] + dp[i-1][j-g][max(0, k-p)]) % mod
				}
			}
		}
	}

	ans := 0
	for j := 0; j <= n; j++ {
		ans = (ans + dp[len(group)][j][minProfit]) % mod
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func main() {}