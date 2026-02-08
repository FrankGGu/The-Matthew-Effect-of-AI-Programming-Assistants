import "fmt"

func maxPoints(points [][]int) int64 {
	m := len(points)
	n := len(points[0])
	dp := make([]int64, n)
	for i := 0; i < n; i++ {
		dp[i] = int64(points[0][i])
	}

	for i := 1; i < m; i++ {
		left := make([]int64, n)
		right := make([]int64, n)

		left[0] = dp[0]
		for j := 1; j < n; j++ {
			left[j] = max(left[j-1]-1, dp[j])
		}

		right[n-1] = dp[n-1]
		for j := n - 2; j >= 0; j-- {
			right[j] = max(right[j+1]-1, dp[j])
		}

		newDp := make([]int64, n)
		for j := 0; j < n; j++ {
			newDp[j] = max(left[j], right[j]) + int64(points[i][j])
		}

		dp = newDp
	}

	ans := dp[0]
	for i := 1; i < n; i++ {
		ans = max(ans, dp[i])
	}

	return ans
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}