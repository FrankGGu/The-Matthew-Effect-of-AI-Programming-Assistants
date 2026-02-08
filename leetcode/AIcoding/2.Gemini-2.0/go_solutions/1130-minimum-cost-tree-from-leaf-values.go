import "math"

func mctFromLeafValues(arr []int) int {
	n := len(arr)
	dp := make([][]int, n)
	maxVal := make([][]int, n)

	for i := 0; i < n; i++ {
		dp[i] = make([]int, n)
		maxVal[i] = make([]int, n)
		maxVal[i][i] = arr[i]
	}

	for i := 0; i < n-1; i++ {
		for j := i + 1; j < n; j++ {
			maxVal[i][j] = int(math.Max(float64(maxVal[i][j-1]), float64(arr[j])))
		}
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			dp[i][j] = math.MaxInt32
			for k := i; k < j; k++ {
				dp[i][j] = int(math.Min(float64(dp[i][j]), float64(dp[i][k]+dp[k+1][j]+maxVal[i][k]*maxVal[k+1][j])))
			}
		}
	}

	return dp[0][n-1]
}