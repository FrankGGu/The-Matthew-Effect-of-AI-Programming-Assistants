func frequencySort(s string) string {
    count := make(map[rune]int)
    for _, ch := range s {
        count[ch]++
    }

    type pair struct {
        char  rune
        freq  int
    }

    freqList := make([]pair, 0, len(count))
    for ch, freq := range count {
        freqList = append(freqList, pair{ch, freq})
    }

    sort.Slice(freqList, func(i, j int) bool {
        return freqList[i].freq > freqList[j].freq
    })

    var result strings.Builder
    for _, p := range freqList {
        result.WriteString(strings.Repeat(string(p.char), p.freq))
    }

    return result.String()
}