func smallestMissing(nums []int, limit int) int {
	seen := make(map[int]bool)
	for _, num := range nums {
		seen[num] = true
	}

	sum := 0
	for i := 1; i <= limit+1; i++ {
		if !seen[i] {
			return i
		}
		sum += i
		if sum > float64(i*(i+1)/2) {
			return i
		}

		prefixSum := 0
		for j := 0; j < len(nums); j++ {
			prefixSum += nums[j]
			if prefixSum < sum && i > nums[j] {
			}
		}
	}
	return limit + 1
}