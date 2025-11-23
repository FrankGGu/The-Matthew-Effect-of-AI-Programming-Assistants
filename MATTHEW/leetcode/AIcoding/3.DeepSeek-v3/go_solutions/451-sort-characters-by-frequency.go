import (
	"sort"
)

func frequencySort(s string) string {
	freq := make(map[rune]int)
	for _, ch := range s {
		freq[ch]++
	}

	chars := make([]rune, 0, len(freq))
	for ch := range freq {
		chars = append(chars, ch)
	}

	sort.Slice(chars, func(i, j int) bool {
		return freq[chars[i]] > freq[chars[j]]
	})

	var res []rune
	for _, ch := range chars {
		for i := 0; i < freq[ch]; i++ {
			res = append(res, ch)
		}
	}

	return string(res)
}