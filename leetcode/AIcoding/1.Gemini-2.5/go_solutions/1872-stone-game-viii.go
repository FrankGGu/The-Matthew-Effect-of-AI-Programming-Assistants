func stoneGameVIII(stones []int) int {
	n := len(stones)

	// Calculate suffix sums
	// suffixSum[i] stores the sum of stones[i...n-1]
	suffixSum := make([]int, n)
	suffix