func subarraysDivByK(nums []int, k int) int {
	remainderCounts := make([]int, k)
	remainderCounts[0] = 1 // Initialize for prefix sum 0 (empty prefix)

	currentSum := 0
	count := 0

	for _, num := range nums {
		currentSum += num
		// Ensure remainder is non-negative
		remainder := (currentSum % k + k) % k

		count += remainderCounts[remainder]
		remainderCounts[remainder]++
	}

	return count
}