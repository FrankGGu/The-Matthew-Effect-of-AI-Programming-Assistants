func finalArrayAfterKOperations(nums []int, k int) []int {
	n := len(nums)
	negatives := 0
	for _, num := range nums {
		if num < 0 {
			negatives++
		}
	}

	if k > 0 {
		if k%2 != 0 {
			minAbs := 1000000001
			minIndex := -1

			for i := 0; i < n; i++ {
				absVal := nums[i]
				if absVal < 0 {
					absVal = -absVal
				}

				if absVal < minAbs {
					minAbs = absVal
					minIndex = i
				}
			}

			nums[minIndex] = -nums[minIndex]
		}
	}

	return nums
}