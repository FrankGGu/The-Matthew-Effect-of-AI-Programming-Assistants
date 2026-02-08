func longestConsecutive(nums []int) int {
	if len(nums) == 0 {
		return 0
	}

	// Use a hash set to store all numbers for O(1) lookups
	numSet := make(map[int]bool)
	for _, num := range nums {
		numSet[num]