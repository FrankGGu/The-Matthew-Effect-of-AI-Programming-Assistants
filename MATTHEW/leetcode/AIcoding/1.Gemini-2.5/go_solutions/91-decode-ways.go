func numDecodings(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	dp_i_minus_2 := 1 // Represents dp[0], ways to decode an empty string
	dp_i_minus_1 := 0 // Represents dp[1], ways to decode s[0]

	if s[0] != '0' {
		dp_i_minus_1 = 1
	}

	for i := 2; i <= n; i++ {
		current_dp := 0

		// Check if s[i-1] (the current single digit) can be decoded
		digit1 := int(s[i-1] - '0')
		if digit1 >= 1 && digit1 <= 9 {
			current_dp += dp_i_minus_1
		}

		// Check if s[i-2:i] (the current two digits) can be decoded
		// s[i-2] is the tens digit, s[i-1] is the units digit
		digit2 := int(s[i-2] - '0')
		num2 := digit2*10 + digit1
		if num2 >= 10 && num2 <= 26 {
			current_dp += dp_i_minus_2
		}

		// Update for the next iteration
		dp_i_minus_2 = dp_i_minus_1
		dp_i_minus_1 = current_dp
	}

	return dp_i_minus_1
}