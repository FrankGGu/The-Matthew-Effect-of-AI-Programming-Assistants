func placeWordInCrossword(crossword [][]byte, word string) bool {
	m := len(crossword)
	n := len(crossword[0])

	check := func(segment []byte, word string) bool {
		if len(segment) != len(word) {
			return false
		}

		canFitForward := true
		for i := 0; i < len(word); i++ {
			if segment[i] != ' ' && segment[i] != word[i] {
				canFitForward = false
				break
			}
		}
		if canFitForward {
			return true
		}

		canFitBackward := true
		for i := 0; i < len(word); i++ {
			if segment[i] != ' ' && segment[i] != word[len(word)-1-i] {
				canFitBackward = false
				break
			}
		}
		return canFitBackward
	}

	for r := 0; r < m; r++ {
		currentSegmentStart := -1
		for c := 0; c < n; c++ {
			if crossword[r][c] == '#' {
				if currentSegmentStart != -1 {
					segment := make([]byte, c-currentSegmentStart)
					for k := 0; k < len(segment); k++ {
						segment[k] = crossword[r][currentSegmentStart+k]
					}
					if check(segment, word) {
						return true
					}
					currentSegmentStart = -1
				}
			} else {
				if currentSegmentStart == -1 {
					currentSegmentStart = c
				}
			}
		}
		if currentSegmentStart != -1 {
			segment := make([]byte, n-currentSegmentStart)
			for k := 0; k < len(segment); k++ {
				segment[k] = crossword[r][currentSegmentStart+k]
			}
			if check(segment, word) {
				return true
			}
		}
	}

	for c := 0; c < n; c++ {
		currentSegmentStart := -1
		for r := 0; r < m; r++ {
			if crossword[r][c] == '#' {
				if currentSegmentStart != -1 {
					segment := make([]byte, r-currentSegmentStart)
					for k := 0; k < len(segment); k++ {
						segment[k] = crossword[currentSegmentStart+k][c]
					}
					if check(segment, word) {
						return true
					}
					currentSegmentStart = -1
				}
			} else {
				if currentSegmentStart == -1 {
					currentSegmentStart = r
				}
			}
		}
		if currentSegmentStart != -1 {
			segment := make([]byte, m-currentSegmentStart)
			for k := 0; k < len(segment); k++ {
				segment[k] = crossword[currentSegmentStart+k][c]
			}
			if check(segment, word) {
				return true
			}
		}
	}

	return false
}