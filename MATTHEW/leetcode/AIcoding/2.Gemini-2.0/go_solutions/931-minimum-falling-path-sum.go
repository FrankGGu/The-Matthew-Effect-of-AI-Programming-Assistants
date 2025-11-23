import "math"

func minFallingPathSum(matrix [][]int) int {
	n := len(matrix)
	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for i := 0; i < n; i++ {
		dp[0][i] = matrix[0][i]
	}

	for i := 1; i < n; i++ {
		for j := 0; j < n; j++ {
			minVal := dp[i-1][j]
			if j > 0 {
				minVal = min(minVal, dp[i-1][j-1])
			}
			if j < n-1 {
				minVal = min(minVal, dp[i-1][j+1])
			}
			dp[i][j] = matrix[i][j] + minVal
		}
	}

	minSum := math.MaxInt32
	for i := 0; i < n; i++ {
		minSum = min(minSum, dp[n-1][i])
	}

	return minSum
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}