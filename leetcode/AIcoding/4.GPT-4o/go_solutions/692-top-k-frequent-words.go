import (
    "sort"
)

func topKFrequent(words []string, k int) []string {
    count := make(map[string]int)
    for _, word := range words {
        count[word]++
    }

    type wordCount struct {
        word  string
        freq  int
    }

    wcList := make([]wordCount, 0, len(count))
    for word, freq := range count {
        wcList = append(wcList, wordCount{word, freq})
    }

    sort.Slice(wcList, func(i, j int) bool {
        if wcList[i].freq == wcList[j].freq {
            return wcList[i].word < wcList[j].word
        }
        return wcList[i].freq > wcList[j].freq
    })

    result := make([]string, 0, k)
    for i := 0; i < k; i++ {
        result = append(result, wcList[i].word)
    }
    return result
}