func longestSquareStreak(nums []int) int {
	sort.Ints(nums)

	numSet := make(map[int]bool)
	for _, num := range nums {
		numSet[num] = true
	}

	streak