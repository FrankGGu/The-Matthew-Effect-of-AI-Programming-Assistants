func countCompleteSubarrays(nums []int) int {
	n := len(nums)
	distinctCount := 0
	seen := make(map[int]bool)
	for _, num := range nums {
		if !seen[num] {
			distinctCount++
			seen[num] = true
		}
	}

	count := 0
	for i := 0; i < n; i++ {
		currentSeen := make(map[int]int)
		currentDistinctCount := 0
		for j := i; j < n; j++ {
			if currentSeen[nums[j]] == 0 {
				currentDistinctCount++
			}
			currentSeen[nums[j]]++

			if currentDistinctCount == distinctCount {
				count++
			}
		}
	}

	return count
}