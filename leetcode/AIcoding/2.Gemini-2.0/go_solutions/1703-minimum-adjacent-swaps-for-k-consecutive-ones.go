import (
	"sort"
)

func minMoves(nums []int, k int) int {
	ones := []int{}
	for i, num := range nums {
		if num == 1 {
			ones = append(ones, i)
		}
	}

	if len(ones) < k {
		return 0
	}

	medians := []int{}
	for i := 0; i <= len(ones)-k; i++ {
		medians = append(medians, ones[i+(k-1)/2])
	}

	prefixSum := make([]int, len(ones)+1)
	for i := 1; i <= len(ones); i++ {
		prefixSum[i] = prefixSum[i-1] + ones[i-1]
	}

	ans := int(^uint(0) >> 1)
	for i := 0; i < len(medians); i++ {
		median := medians[i]
		mid := (k - 1) / 2
		left := i
		right := i + k - 1

		moves := 0
		moves += median*(mid-left) - (prefixSum[mid+1] - prefixSum[left])
		moves += (prefixSum[right+1] - prefixSum[mid+1]) - median*(right-mid)

		expected := 0
		for j := 0; j < k; j++ {
			expected += abs(j - (k-1)/2)
		}
		moves -= expected

		ans = min(ans, moves)
	}

	return ans
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