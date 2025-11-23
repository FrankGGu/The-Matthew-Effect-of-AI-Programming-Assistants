func equalFrequency(word string) bool {
	freq := make(map[rune]int)
	for _, r := range word {
		freq[r]++
	}

	for _, r := range word {
		tempFreq := make(map[rune]int)
		for k, v := range freq {
			if k != r {
				tempFreq[k] = v
			} else if v > 1 {
				tempFreq[k] = v - 1
			}
		}

		if len(tempFreq) == 0 {
			return true
		}

		firstFreq := -1
		equal := true
		for _, v := range tempFreq {
			if firstFreq == -1 {
				firstFreq = v
			} else if v != firstFreq {
				equal = false
				break
			}
		}

		if equal {
			return true
		}
	}

	return false
}