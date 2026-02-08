func getLucky(s string, k int) int {
	digitString := ""
	for _, char := range s {
		// Convert character to its 1-indexed alphabet position
		val := int(char - 'a' + 1)
		digitString += strconv.Itoa(val)
	}

	currentNumStr := digitString
	for i := 0; i < k; i++ {
		sum := 0
		for _, charDigit := range currentNumStr {
			// Convert character digit to integer and add to sum
			sum += int(charDigit - '0')
		}
		// Update currentNumStr to the string representation of the new sum
		currentNumStr = strconv.Itoa(sum)
	}

	// After k transformations, currentNumStr holds the final sum as a string.
	// Convert it to an integer and return.
	finalSum, _ := strconv.Atoi(currentNumStr)
	return finalSum
}