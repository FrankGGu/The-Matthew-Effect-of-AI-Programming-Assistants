type charFrequency struct {
	char rune
	freq int
}

func frequencySort(s string) string {
	freqMap := make(map[rune]int)
	for _, char := range s {
		freqMap[char]++
	}

	var charFreqs []charFrequency
	for char, freq := range freqMap {
		charFreqs = append(charFreqs, charFrequency{char: char, freq: freq})
	}

	sort.Slice(charFreqs, func(i, j int) bool {
		// Sort by frequency in descending order
		return charFreqs[i].freq > charFreqs[j].freq
	})

	var result strings.Builder
	for _, cf := range charFreqs {
		for i := 0; i < cf.freq; i++ {
			result.WriteRune(cf.char)
		}
	}

	return result.String()
}