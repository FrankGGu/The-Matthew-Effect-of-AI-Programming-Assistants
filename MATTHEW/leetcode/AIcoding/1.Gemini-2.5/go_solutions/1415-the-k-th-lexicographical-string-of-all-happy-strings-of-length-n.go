func getHappyString(n int, k int) string {
	totalHappyStrings := 3 * (1 << (n - 1))
	if k > totalHappyStrings {
		return ""
	}

	// Convert k to 0-indexed for easier calculations
	k--

	ans := make([]byte, n)

	// Determine the first character
	// Each initial choice ('a', 'b', 'c') leads to (1 << (n-1)) happy strings
	countPerInitialChoice := 1 << (n - 1)

	if k < countPerInitialChoice {
		ans[0] = 'a'
	} else if k < 2*countPerInitialChoice {
		ans[0] = 'b'
		k -= countPerInitialChoice
	} else {
		ans[0] = 'c'
		k -= 2 * countPerInitialChoice
	}

	// Determine subsequent characters
	for i := 1; i < n; i++ {
		prevChar := ans[i-1]

		// Number of happy strings that can be formed from this point onwards
		// if we pick one of the two valid choices.
		// This is 2^(n - (i+1))
		remainingCountPerChoice := 1 << (n - (i + 1))

		// Find the two possible next characters
		var choice1, choice2 byte
		if prevChar == 'a' {
			choice1 = 'b'
			choice2 = 'c'
		} else if prevChar == 'b' {
			choice1 = 'a'
			choice2 = 'c'
		} else { // prevChar == 'c'
			choice1 = 'a'
			choice2 = 'b'
		}

		// Decide which of the two choices to pick
		if k < remainingCountPerChoice {
			ans[i] = choice1
		} else {
			ans[i] = choice2
			k -= remainingCountPerChoice
		}
	}

	return string(ans)
}