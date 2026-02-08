import (
	"sort"
)

func minDeletions(s string, k int) int {
	freqMap := make(map[rune]int)
	for _, char := range s {
		freqMap[char]++
	}

	if len(freqMap) <= k {
		return 0
	}

	frequencies := make([]int, 0, len(freqMap))
	for _, freq := range freqMap {
		frequencies = append(frequencies, freq)
	}

	sort.Ints(frequencies)

	deletions := 0
	distinctCount := len(frequencies)

	for i := 0; i < len(frequencies); i++ {
		if distinctCount > k {
			deletions += frequencies[i]
			distinctCount--
		} else {
			break
		}
	}

	return deletions
}