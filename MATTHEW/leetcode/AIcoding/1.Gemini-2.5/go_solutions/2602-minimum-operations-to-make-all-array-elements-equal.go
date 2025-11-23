func minOperations(n int, queries []int) []int64 {
	results := make([]int64, len(queries))

	// The array is arr = [1, 3, 5, ..., 2*n - 1]
	// The elements are of the form 2k + 1 for k =