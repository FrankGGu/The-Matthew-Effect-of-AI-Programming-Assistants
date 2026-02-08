import (
	"math"
	"sort"
)

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minPositiveSumSubarray(nums []int) int {
	minPositiveSum := math.MaxInt
	currentSum := 0

	prefixSums := []int{0} 

	for _, num := range nums {
		currentSum += num

		idx := sort.SearchInts(prefixSums, currentSum)

		if idx > 0 {
			candidateSum := currentSum - prefixSums[idx-1]
			minPositiveSum = min(minPositiveSum, candidateSum)
		}

		prefixSums = append(prefixSums[:idx], append([]int{currentSum}, prefixSums[idx:]...)...)
	}

	if minPositiveSum == math.MaxInt {
		return -1
	}
	return minPositiveSum
}