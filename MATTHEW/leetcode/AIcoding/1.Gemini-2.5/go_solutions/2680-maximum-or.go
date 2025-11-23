func maximumOr(nums []int, x int) int64 {
	var totalOR int64 = 0
	for _, num := range nums {
		totalOR |= int64(num)
	}

	var maxOverallOR int64 = 0
	for _, num := range nums {
		shiftedVal := int6