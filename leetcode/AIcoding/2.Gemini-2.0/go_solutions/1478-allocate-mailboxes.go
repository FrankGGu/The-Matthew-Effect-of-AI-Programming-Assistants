import (
	"math"
	"sort"
)

func minDistance(houses []int, k int) int {
	n := len(houses)
	sort.Ints(houses)

	cost := make([][]int, n)
	for i := 0; i < n; i++ {
		cost[i] = make([]int, n)
		for j := i; j < n; j++ {
			median := houses[(i+j)/2]
			for l := i; l <= j; l++ {
				cost[i][j] += abs(houses[l] - median)
			}
		}
	}

	dp := make([][]int, n)
	for i := 0; i < n; i++ {
		dp[i] = make([]int, k+1)
		for j := 0; j <= k; j++ {
			dp[i][j] = math.MaxInt32
		}
	}

	for i := 0; i < n; i++ {
		dp[i][1] = cost[0][i]
	}

	for m := 2; m <= k; m++ {
		for i := m - 1; i < n; i++ {
			for j := m - 2; j < i; j++ {
				dp[i][m] = min(dp[i][m], dp[j][m-1]+cost[j+1][i])
			}
		}
	}

	return dp[n-1][k]
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}