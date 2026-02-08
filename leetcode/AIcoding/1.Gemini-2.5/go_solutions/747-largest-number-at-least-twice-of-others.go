func dominantIndex(nums []int) int {
	if len(nums) == 0 {
		return -1
	}

	max1 := -1
	max2 := -1
	maxIdx := -1

	for i, num := range nums {
		if num > max1 {
			max2 = max1
			max1 = num
			maxIdx = i
		} else if num > max2 {
			max2 = num
		}
	}

	if max1 >= 2*max2 {
		return maxIdx
	}
	return -1
}