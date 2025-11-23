import (
	"math"
)

func minSpaceWastedKResizing(nums []int, k int) int {
	n := len(nums)
	prefixSum := make([]int, n+1)
	maxVal := make([][]int, n, n)
	for i := 0; i < n; i++ {
		maxVal[i] = make([]int, n)
		maxVal[i][i] = nums[i]
		prefixSum[i+1] = prefixSum[i] + nums[i]
	}

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			maxVal[i][j] = max(maxVal[i][j-1], nums[j])
		}
	}

	dp := make([][]int, n, n)
	for i := 0; i < n; i++ {
		dp[i] = make([]int, k+1)
		for j := 0; j <= k; j++ {
			dp[i][j] = math.MaxInt32
		}
	}

	for i := 0; i < n; i++ {
		dp[i][0] = maxVal[0][i]*(i+1) - prefixSum[i+1]
	}

	for i := 0; i < n; i++ {
		for j := 1; j <= k; j++ {
			for x := 0; x < i; x++ {
				dp[i][j] = min(dp[i][j], dp[x][j-1]+maxVal[x+1][i]*(i-x)- (prefixSum[i+1]-prefixSum[x+1]))
			}
		}
	}

	return dp[n-1][k]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}