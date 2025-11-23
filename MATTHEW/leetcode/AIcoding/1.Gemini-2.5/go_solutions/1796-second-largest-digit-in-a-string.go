func secondHighest(s string) int {
	seenDigits := [10]bool{} // To track unique digits from 0 to 9

	for _, r := range s {
		if unicode.IsDigit(r) {
			digit := int(r - '0') // Convert rune to integer digit
			seenDigits[digit] = true
		}
	}

	secondLargest := -1
	foundCount := 0

	// Iterate from 9 down to 0 to find the largest and then the second largest unique digit
	for i := 9; i >= 0; i-- {
		if seenDigits[i] {
			foundCount++
			if foundCount == 2 { // This is the second unique digit found (from largest downwards)
				secondLargest = i
				break // Found the second largest, no need to continue
			}
		}
	}

	return secondLargest
}