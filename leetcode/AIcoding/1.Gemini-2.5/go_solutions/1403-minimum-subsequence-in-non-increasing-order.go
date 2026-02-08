func minSubsequence(nums []int) []int {
	totalSum := 0
	for _, num := range nums {
		totalSum += num
	}

	sort.Slice(nums, func(i, j int) bool {
		return nums[i] > nums[j]
	})

	subsequence := []int{}
	currentSubsequenceSum := 0

	for _, num := range nums {
		subsequence = append(subsequence, num)
		currentSubsequenceSum += num
		totalSum -= num 

		if currentSubsequenceSum > totalSum {
			break
		}
	}

	return subsequence
}