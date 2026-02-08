func countMaxOrSubsets(nums []int) int {
	maxOr := 0
	for _, num := range nums {
		maxOr |= num
	}

	count := 0
	var backtrack func(index int, currentOr int)
	backtrack = func(index int, currentOr int) {
		if index == len(nums) {
			if currentOr == maxOr {
				count++
			}
			return
		}

		backtrack(index+1, currentOr|nums[index])
		backtrack(index+1, currentOr)
	}

	backtrack(0, 0)
	return count
}