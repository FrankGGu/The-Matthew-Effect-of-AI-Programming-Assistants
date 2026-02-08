import "sort"

func minMoves(nums []int, k int) int {
	positions := []int{}
	for i, num := range nums {
		if num == 1 {
			positions = append(positions, i)
		}
	}

	if len(positions) < k {
		return 0
	}

	prefixSum := make([]int, len(positions)+1)
	for i := 1; i <= len(positions); i++ {
		prefixSum[i] = prefixSum[i-1] + positions[i-1]
	}

	ans := int(^uint(0) >> 1)
	for i := 0; i <= len(positions)-k; i++ {
		mid := i + k/2
		median := positions[mid]
		left := mid - i
		right := k - left - 1
		cost := (median*left - (prefixSum[mid+1] - prefixSum[i])) + ((prefixSum[i+k] - prefixSum[mid+1]) - median*right)
		cost -= (k/2)*(k/2+1)/2 + ((k-1)/2)*((k-1)/2+1)/2
		ans = min(ans, cost)
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}