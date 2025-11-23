package main

func subsets(nums []int) [][]int {
	var result [][]int
	var currentSubset []int

	var backtrack func(start int)
	backtrack = func(start int) {
		temp := make([]int, len(currentSubset))
		copy(temp, currentSubset)
		result = append(result, temp)

		for i := start; i < len(nums); i++ {
			currentSubset = append(currentSubset, nums[i])
			backtrack(i + 1)
			currentSubset = currentSubset[:len(currentSubset)-1]
		}
	}

	backtrack(0)
	return result
}