import "fmt"

func strangePrinter(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for i := range dp {
		dp[i][i] = 1
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			dp[i][j] = 1<<31 - 1
			for k := i; k < j; k++ {
				cost := dp[i][k] + dp[k+1][j]
				if s[k] == s[j] {
					cost--
				}
				if cost < dp[i][j] {
					dp[i][j] = cost
				}
			}
		}
	}

	return dp[0][n-1]
}