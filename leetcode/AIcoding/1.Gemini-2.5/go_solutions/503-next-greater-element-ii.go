func nextGreaterElements(nums []int) []int {
	n := len(nums)
	result := make([]int, n)
	for i := range result {
		result[i] = -1
	}

	stack := []int{} // Stack stores indices

	// Iterate twice to handle circularity