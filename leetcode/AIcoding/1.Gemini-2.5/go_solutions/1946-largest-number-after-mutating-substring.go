func largestNumberAfterMutatingSubstring(num string, change []int) string {
	n := len(num)
	numBytes := []byte(num)

	mutating := false

	for i := 0; i < n; i++ {
		digit := numBytes[i] - '0'
		changedDigit := change[digit]

		if !mutating {
			if changedDigit > digit {
				mutating = true
				numBytes[i] = byte(changedDigit + '0')
			}
			// If changedDigit <= digit, we don't start mutating here.
			// numBytes[i] remains unchanged.
		} else {
			// We are already in a mutating phase.
			if changedDigit >= digit {
				numBytes[i] = byte(changedDigit + '0')
			} else {
				// If changedDigit < digit, we must stop mutating.
				// The current digit and all subsequent digits remain unchanged.
				break
			}
		}
	}

	return string(numBytes)
}