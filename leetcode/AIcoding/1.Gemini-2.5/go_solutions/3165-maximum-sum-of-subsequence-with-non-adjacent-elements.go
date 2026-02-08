package main

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxSumNonAdjacent(nums []int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}

	include := nums[0]
	exclude := 0

	for i := 1; i < n; i++ {
		newExclude := max(include, exclude)
		newInclude := exclude + nums[i]
		exclude = newExclude
		include = newInclude
	}

	return max(include, exclude)
}