import (
	"fmt"
	"math"
)

func minCost(words []string, k int, costs []int) int {
	n := len(words)
	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dp[i] = math.MaxInt32
	}

	for i := 1; i <= n; i++ {
		for j := i; j >= 1; j-- {
			length := 0
			for l := j; l <= i; l++ {
				length += len(words[l-1])
				if l < i {
					length++
				}
			}

			if length <= k {
				cost := 0
				if length < k {
					cost = (k - length) * (k - length)
				}
				dp[i] = min(dp[i], dp[j-1]+cost)
			}
		}
	}

	return dp[n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}