func subsets(nums []int) [][]int {
	var result [][]int
	var currentSubset []int

	var backtrack func(start int)
	backtrack = func(start int) {
		// Add a copy of the current subset to the result
		temp := make([]int, len(currentSubset))
		copy(temp, currentSubset)
		result = append(result, temp)

		// Explore choices
		for i := start; i < len(nums); i++ {
			// Choose
			currentSubset = append(currentSubset, nums[i])
			// Explore
			backtrack(i + 1)
			// Unchoose (backtrack)
			currentSubset = currentSubset[:len(currentSubset)-1]
		}
	}

	backtrack(0)
	return result
}