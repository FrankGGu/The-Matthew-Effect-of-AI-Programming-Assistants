package main

type WordFilter struct {
    mapPrefix map[string]int
}

func Constructor(words []string) WordFilter {
    m := make(map[string]int)
    for i, word := range words {
        for j := 0; j < len(word); j++ {
            prefix := word[j:]
            for k := len(word); k >= 0; k-- {
                suffix := word[:k]
                m[prefix+"-"+suffix] = i
            }
        }
    }
    return WordFilter{m}
}

func (this *WordFilter) Search(prefix string, suffix string) int {
    key := prefix + "-" + suffix
    if idx, ok := this.mapPrefix[key]; ok {
        return idx
    }
    return -1
}