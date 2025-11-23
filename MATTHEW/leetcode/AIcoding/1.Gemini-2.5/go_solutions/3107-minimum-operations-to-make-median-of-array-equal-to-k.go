import (
	"sort"
)

func minOperationsToMakeMedianK(nums []int, k int) int64 {
	sort.Ints(nums)

	n := len(nums)
	medianIdx := n / 2
	var operations int64 = 0

	// Operations to make the median element equal to k
	operations += int64(abs(nums[medianIdx] - k))

	// Operations for elements to the left of the median
	// These elements must be <= k. If nums[i] > k, decrease it to k.
	for i := 0; i < medianIdx; i++ {
		if nums[i] > k {
			operations += int64(nums[i] - k)
		}
	}

	// Operations for elements to the right of the median
	// These elements must be >= k. If nums[i] < k, increase it to k.
	for i := medianIdx + 1; i < n; i++ {
		if nums[i] < k {
			operations += int64(k - nums[i])
		}
	}

	return operations
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}