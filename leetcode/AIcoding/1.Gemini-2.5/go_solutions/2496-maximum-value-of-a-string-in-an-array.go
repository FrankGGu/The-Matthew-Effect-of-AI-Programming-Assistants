func maximumValue(strs []string) int {
	maxVal := 0

	for _, s := range strs {
		currentVal := 0
		isNumeric := true
		for _, r := range s {
			if !unicode.IsDigit(r) {
				isNumeric = false
				break
			}
		}

		if isNumeric {
			parsedInt, _ := strconv.Atoi(s)
			currentVal = parsedInt
		} else {
			currentVal = len(s)
		}

		if currentVal > maxVal {
			maxVal = currentVal
		}
	}

	return maxVal
}