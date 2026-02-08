import "fmt"

func largestSumOfAverages(nums []int, k int) float64 {
	n := len(nums)
	prefixSum := make([]float64, n+1)
	for i := 1; i <= n; i++ {
		prefixSum[i] = prefixSum[i-1] + float64(nums[i-1])
	}

	dp := make([][]float64, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]float64, k+1)
	}

	for i := 1; i <= n; i++ {
		dp[i][1] = prefixSum[i] / float64(i)
	}

	for j := 2; j <= k; j++ {
		for i := j; i <= n; i++ {
			for x := j - 1; x < i; x++ {
				dp[i][j] = max(dp[i][j], dp[x][j-1]+(prefixSum[i]-prefixSum[x])/float64(i-x))
			}
		}
	}

	return dp[n][k]
}

func max(a, b float64) float64 {
	if a > b {
		return a
	}
	return b
}