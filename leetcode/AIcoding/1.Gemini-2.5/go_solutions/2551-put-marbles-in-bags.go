import (
	"sort"
)

func putMarbles(weights []int, k int) int64 {
	n := len(weights)
	if k == 1 || n == k {
		return 0
	}

	cutCosts := make([]int, n-1)
	for i := 0; i < n-1; i++ {
		cutCosts[i] = weights[i] + weights[i+1]
	}

	sort.Ints(cutCosts)

	var minScoreSum int64
	for i := 0; i < k-1; i++ {
		minScoreSum += int64(cutCosts[i])
	}

	var maxScoreSum int64
	for i := 0; i < k-1; i++ {
		maxScoreSum += int64(cutCosts[n-2-i])
	}

	return maxScoreSum - minScoreSum
}