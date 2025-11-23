import "fmt"

func findMaxForm(strs []string, m int, n int) int {
	dp := make([][]int, m+1)
	for i := range dp {
		dp[i] = make([]int, n+1)
	}

	for _, str := range strs {
		zeros, ones := countZerosAndOnes(str)
		for i := m; i >= zeros; i-- {
			for j := n; j >= ones; j-- {
				dp[i][j] = max(dp[i][j], dp[i-zeros][j-ones]+1)
			}
		}
	}

	return dp[m][n]
}

func countZerosAndOnes(s string) (int, int) {
	zeros := 0
	ones := 0
	for _, char := range s {
		if char == '0' {
			zeros++
		} else {
			ones++
		}
	}
	return zeros, ones
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}