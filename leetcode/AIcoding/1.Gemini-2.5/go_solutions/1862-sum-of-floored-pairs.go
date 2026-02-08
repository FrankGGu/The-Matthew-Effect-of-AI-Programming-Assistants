func sumOfFlooredPairs(nums []int) int {
	maxVal := 0
	for _, num := range nums {
		if num > maxVal {
			maxVal = num
		}
	}

	freq := make([]int, maxVal+1)
	for _, num := range