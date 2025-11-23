func partitionString(s string, k int) int {
	count := 1
	currentNum := int64(0)
	K := int64(k)

	for i := 0; i < len(s); i++ {
		digit := int64(s[i] - '0')

		// Calculate the number if the current digit is appended.
		// Since currentNum is at most K (max 10^9), currentNum * 10 could be up to 10^10.
		// This fits within an int64.
		if currentNum*10+digit > K {
			// If appending the digit makes the number too large,
			// we must start a new substring with the current digit.
			count++
			currentNum = digit
		} else {
			// Otherwise, append the digit to the current number.
			currentNum = currentNum*10 + digit
		}
	}

	return count
}