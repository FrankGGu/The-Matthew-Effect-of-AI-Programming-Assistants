func longerContiguousSegments(s string) bool {
	maxOnes, maxZeros := 0, 0
	currOnes, currZeros := 0, 0

	for _, char := range s {
		if char == '1' {
			currOnes++
			currZeros = 0
		} else {
			currZeros++
			currOnes = 0
		}

		if currOnes > maxOnes {
			maxOnes = currOnes
		}

		if currZeros > maxZeros {
			maxZeros = currZeros
		}
	}

	return maxOnes > maxZeros
}