func frequencySort(nums []int) []int {
	freqMap := make(map[int]int)
	for _, num := range nums {
		freqMap[num]++
	}

	sort.Slice(nums, func(i, j int) bool {
		freqI := freqMap[nums[i]]
		freqJ := freqMap[nums[j]]

		if freqI != freqJ {
			return freqI < freqJ // Sort by frequency in increasing order
		}
		return nums[i] > nums[j] // If frequencies are the same, sort by value in decreasing order
	})

	return nums
}