func pancakeSort(arr []int) []int {
	n := len(arr)
	if n <= 1 {
		return []int{}
	}

	res := []int{}

	// Helper function to reverse a prefix of the array
	// k is the length of the prefix to reverse (i.e., elements from index