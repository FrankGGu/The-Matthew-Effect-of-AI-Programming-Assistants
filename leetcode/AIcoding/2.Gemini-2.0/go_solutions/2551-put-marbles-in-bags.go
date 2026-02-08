import (
	"sort"
)

func putMarbles(weights []int, k int) int {
	n := len(weights)
	if k <= 1 || k >= n {
		return 0
	}

	pairs := make([]int, n-1)
	for i := 0; i < n-1; i++ {
		pairs[i] = weights[i] + weights[i+1]
	}

	sort.Ints(pairs)

	minSum := 0
	maxSum := 0

	for i := 0; i < k-1; i++ {
		minSum += pairs[i]
		maxSum += pairs[n-2-i]
	}

	return maxSum - minSum
}