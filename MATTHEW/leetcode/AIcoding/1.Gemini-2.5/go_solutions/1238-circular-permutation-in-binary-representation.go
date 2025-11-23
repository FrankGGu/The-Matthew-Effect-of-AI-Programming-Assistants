func circularPermutation(n int, start int) []int {
	size := 1 << n
	result := make([]int, size)
	for i := 0; i < size; i++ {
		result[i] = i ^ (i >> 1)
	}

	startIndex := -1
	for i