func countMaxOrSubsets(nums []int) int {
	n := len(nums)

	maxOR := 0
	for _, num := range nums {
		maxOR |= num
	}

	count := 0
	var backtrack func(index int, currentOR int)
	backtrack = func(index int, currentOR int) {
		if index == n {
			if currentOR == maxOR {
				count++
			}
			return
		}

		backtrack(index+1, currentOR|nums[index])
		backtrack(index+1, currentOR)
	}

	backtrack(0, 0)
	return count
}