func removeDigit(number string, digit byte) string {
	maxResult := ""

	for i := 0; i < len(number); i++ {
		if number[i] == digit {
			currentResult := number[:i] + number[i+1:]
			if maxResult == "" || currentResult > maxResult {
				maxResult = currentResult
			}
		}
	}

	return maxResult
}