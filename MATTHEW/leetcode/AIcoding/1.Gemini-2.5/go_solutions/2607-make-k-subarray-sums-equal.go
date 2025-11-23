func makeSubKSumEqual(arr []int, k int) int64 {
	n := len(arr)
	var totalCost int64 = 0

	// `visited` array to keep track of elements that have already been part of a group.
	//