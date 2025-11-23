func findMaxLength(nums []int) int {
	maxLength := 0
	count := 0
	countMap := make(map[int]int)
	countMap[0] = -1

	for i := 0; i < len(nums); i++ {
		if nums[i] == 0 {
			count--
		} else {
			count++
		}

		if index, ok := countMap[count]; ok {
			maxLength = max(maxLength, i-index)
		} else {
			countMap[count] = i
		}
	}

	return maxLength
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}