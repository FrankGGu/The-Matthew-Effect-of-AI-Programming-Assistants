func numsSameConsecDiff(n int, k int) []int {
	result := []int{}

	if n == 1 {
		for i := 0; i <= 9; i++ {
			result = append(result, i)
		}
		return result
	}

	var dfs func(currentNum int, digitCount int)
	dfs = func(currentNum int, digitCount int) {
		if digitCount == n {
			result = append(result, currentNum)
			return
		}

		lastDigit := currentNum % 10

		// Option 1: nextDigit = lastDigit + k
		nextDigit1 := lastDigit + k
		if nextDigit1 <= 9 {
			dfs(currentNum*10+nextDigit1, digitCount+1)
		}

		// Option 2: nextDigit = lastDigit - k
		// Only explore if k is not 0 to avoid duplicate paths when k=0
		// and ensure nextDigit is non-negative
		if k != 0 {
			nextDigit2 := lastDigit - k
			if nextDigit2 >= 0 {
				dfs(currentNum*10+nextDigit2, digitCount+1)
			}
		}
	}

	// Start DFS with digits 1-9 (first digit cannot be 0 for n > 1)
	for i := 1; i <= 9; i++ {
		dfs(i, 1)
	}

	return result
}