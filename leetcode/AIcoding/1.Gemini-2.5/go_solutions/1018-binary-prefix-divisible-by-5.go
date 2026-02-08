func prefixesDivBy5(A []int) []bool {
	n := len(A)
	result := make([]bool, n)
	currentRemainder := 0

	for i := 0; i < n; i++ {
		currentRemainder = (currentRemainder*2 + A[i]) % 5
		if currentRemainder == 0 {
			result[i] = true
		} else {
			result[i] = false
		}
	}

	return result
}