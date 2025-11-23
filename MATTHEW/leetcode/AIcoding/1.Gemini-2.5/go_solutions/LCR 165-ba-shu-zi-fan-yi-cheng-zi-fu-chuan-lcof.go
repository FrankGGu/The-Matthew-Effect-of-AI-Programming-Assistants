import "strconv"

func translateNum(num int) int {
	s := strconv.Itoa(num)
	n := len(s)

	a := 1 // Represents dp[i-2], initialized as dp[0]
	b := 1 // Represents dp[i-1], initialized as dp[1]

	for i := 2; i <= n; i++ {
		current_dp := b // Option 1: Translate s[i-1] as a single digit. This always adds dp[i-1] ways.

		// Option 2: Translate s[i-2...i-1] as a two-digit number.
		// Check if the two-digit number formed by s[i-2] and s[i-1] is between 10 and 25.
		sub := s[i-2 : i]
		val, _ := strconv.Atoi(sub)

		if val >= 10 && val <= 25 {
			current_dp += a // Add dp[i-2] ways
		}

		// Update a and b for the next iteration
		a = b
		b = current_dp
	}

	return b // b now holds dp[n]
}