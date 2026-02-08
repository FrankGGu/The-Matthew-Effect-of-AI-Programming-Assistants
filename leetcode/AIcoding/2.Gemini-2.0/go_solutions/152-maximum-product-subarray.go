func maxProduct(nums []int) int {
	maxSoFar := nums[0]
	minSoFar := nums[0]
	result := nums[0]

	for i := 1; i < len(nums); i++ {
		curr := nums[i]
		tempMax := max(curr, max(maxSoFar*curr, minSoFar*curr))
		minSoFar = min(curr, min(maxSoFar*curr, minSoFar*curr))

		maxSoFar = tempMax

		result = max(result, maxSoFar)
	}

	return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}