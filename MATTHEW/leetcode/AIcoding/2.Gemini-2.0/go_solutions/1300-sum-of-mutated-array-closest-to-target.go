import (
	"fmt"
	"sort"
)

func findBestValue(arr []int, target int) int {
	sort.Ints(arr)
	n := len(arr)
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + arr[i]
	}

	l, r := 0, arr[n-1]
	bestValue := 0
	minDiff := int(1e9)

	for l <= r {
		mid := l + (r-l)/2
		sum := 0
		index := sort.SearchInts(arr, mid)
		sum = prefixSum[index] + (n-index)*mid

		diff := abs(sum - target)
		if diff < minDiff {
			minDiff = diff
			bestValue = mid
		} else if diff == minDiff && mid < bestValue {
			bestValue = mid
		}

		if sum > target {
			r = mid - 1
		} else {
			l = mid + 1
		}
	}

	return bestValue
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}