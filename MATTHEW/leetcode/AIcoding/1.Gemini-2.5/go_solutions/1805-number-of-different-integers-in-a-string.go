func numDifferentIntegers(word string) int {
	uniqueNums := make(map[string]struct{})
	n := len(word)
	i := 0

	for i < n {
		if unicode.IsDigit(rune(word[i])) {
			// Found a digit, start of a number
			j := i
			for j < n && unicode.IsDigit(rune(word[j])) {
				j++
			}
			// Number string extracted is word[i:j]
			numStr := word[i:j]

			// Remove leading zeros
			k := 0
			for k < len(numStr)-1 && numStr[k] == '0' {
				k++
			}
			processedNum := numStr[k:]

			uniqueNums[processedNum] = struct{}{}
			i = j // Continue search from after this number
		} else {
			// Not a digit, move to next character
			i++
		}
	}
	return len(uniqueNums)
}