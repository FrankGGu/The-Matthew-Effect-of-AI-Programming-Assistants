import (
	"sort"
	"strings"
)

func frequencySort(s string) string {
	freqMap := make(map[rune]int)
	for _, r := range s {
		freqMap[r]++
	}

	type CharFreq struct {
		Char  rune
		Freq  int
	}

	charFreqs := make([]CharFreq, 0, len(freqMap))
	for char, freq := range freqMap {
		charFreqs = append(charFreqs, CharFreq{Char: char, Freq: freq})
	}

	sort.Slice(charFreqs, func(i, j int) bool {
		return charFreqs[i].Freq > charFreqs[j].Freq
	})

	var result strings.Builder
	for _, cf := range charFreqs {
		for i := 0; i < cf.Freq; i++ {
			result.WriteRune(cf.Char)
		}
	}

	return result.String()
}