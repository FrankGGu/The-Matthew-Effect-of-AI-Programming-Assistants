func circularPermutation(n int, start int) []int {
	result := make([]int, 1<<n)
	for i := 0; i < (1 << n); i++ {
		result[i] = i ^ (i >> 1)
	}

	startIndex := 0
	for i := 0; i < (1 << n); i++ {
		if result[i] == start {
			startIndex = i
			break
		}
	}

	rotatedResult := make([]int, 1<<n)
	for i := 0; i < (1 << n); i++ {
		rotatedResult[i] = result[(startIndex+i)%(1<<n)]
	}

	return rotatedResult
}