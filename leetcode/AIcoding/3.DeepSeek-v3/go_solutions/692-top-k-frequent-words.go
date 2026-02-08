import (
	"sort"
)

type wordFreq struct {
	word string
	freq int
}

func topKFrequent(words []string, k int) []string {
	freqMap := make(map[string]int)
	for _, word := range words {
		freqMap[word]++
	}

	var wf []wordFreq
	for word, freq := range freqMap {
		wf = append(wf, wordFreq{word, freq})
	}

	sort.Slice(wf, func(i, j int) bool {
		if wf[i].freq == wf[j].freq {
			return wf[i].word < wf[j].word
		}
		return wf[i].freq > wf[j].freq
	})

	result := make([]string, k)
	for i := 0; i < k; i++ {
		result[i] = wf[i].word
	}

	return result
}