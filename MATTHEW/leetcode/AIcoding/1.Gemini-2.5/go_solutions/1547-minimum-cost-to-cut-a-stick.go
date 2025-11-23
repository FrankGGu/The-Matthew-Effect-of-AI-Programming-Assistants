import (
	"math"
	"sort"
)

func minCost(n int, cuts []int) int {
	allCuts := make([]int, len(cuts)+2)
	allCuts[0] = 0
	for i, c := range cuts {
		allCuts[i+1] = c
	}
	allCuts[len(allCuts)-1] = n

	sort.Ints(allCuts)

	m := len(allCuts)
	dp := make([][]int64, m)
	for i := range dp {
		dp[i] = make([]int64, m)
	}

	for length := 2; length < m; length++ {
		for i := 0; i < m-length; i++ {
			j := i + length
			dp[i][j] = math.MaxInt64

			for k := i + 1; k < j; k++ {
				cost := int64(allCuts[j]-allCuts[i]) + dp[i][k] + dp[k][j]
				if cost < dp[i][j] {
					dp[i][j] = cost
				}
			}
		}
	}

	return int(dp[0][m-1])
}