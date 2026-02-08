func numsSameConsecDiff(n int, k int) []int {
	result := []int{}

	var dfs func(int, int)
	dfs = func(num int, digits int) {
		if digits == n {
			result = append(result, num)
			return
		}

		lastDigit := num % 10

		if lastDigit+k <= 9 {
			dfs(num*10+lastDigit+k, digits+1)
		}

		if k != 0 && lastDigit-k >= 0 {
			dfs(num*10+lastDigit-k, digits+1)
		}
	}

	for i := 1; i <= 9; i++ {
		dfs(i, 1)
	}

	return result
}