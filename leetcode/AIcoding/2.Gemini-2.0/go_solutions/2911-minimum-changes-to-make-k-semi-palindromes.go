import (
	"fmt"
	"math"
)

func minChanges(s string, k int) int {
	n := len(s)
	cost := make([][]int, n)
	for i := 0; i < n; i++ {
		cost[i] = make([]int, n)
		for j := i; j < n; j++ {
			cost[i][j] = calculateCost(s, i, j)
		}
	}

	dp := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]int, k+1)
		for j := 0; j <= k; j++ {
			dp[i][j] = math.MaxInt32
		}
	}
	dp[0][0] = 0

	for i := 1; i <= n; i++ {
		for j := 1; j <= k; j++ {
			for l := 0; l < i; l++ {
				if dp[l][j-1] != math.MaxInt32 {
					dp[i][j] = min(dp[i][j], dp[l][j-1]+cost[l][i-1])
				}
			}
		}
	}

	return dp[n][k]
}

func calculateCost(s string, left, right int) int {
	count := 0
	for i := left; i <= right; i++ {
		for j := i + 1; j <= right; j++ {
			if (j-i+1)%2 == 0 {
				mid := (i + j) / 2
				l := mid
				r := mid + 1

				for l >=i && r <=j {
					if s[l] != s[r] {
						count++
					}
					l--
					r++
				}
			}
		}
	}

	minCost := math.MaxInt32
	for length := 1; length <= right-left+1; length++ {
		if (right-left+1)%length == 0 {
			currentCost := 0

			for start := left; start <= right; start += length {
				end := min(right, start + length -1)

				l := start
				r := end

				for l < r {
					if s[l] != s[r] {
						currentCost++
					}
					l++
					r--
				}
			}
			minCost = min(minCost, currentCost)
		}
	}

	return minCost
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}