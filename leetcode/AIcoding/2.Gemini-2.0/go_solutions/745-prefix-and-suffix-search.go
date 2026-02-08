type WordFilter struct {
    trie map[string]int
}

func Constructor(words []string) WordFilter {
    t := make(map[string]int)
    for i, word := range words {
        for j := 0; j <= len(word); j++ {
            prefix := word[:j]
            for k := 0; k <= len(word); k++ {
                suffix := word[len(word)-k:]
                t[prefix+"#"+suffix] = i
            }
        }
    }
    return WordFilter{trie: t}
}

func (this *WordFilter) F(prefix string, suffix string) int {
    if val, ok := this.trie[prefix+"#"+suffix]; ok {
        return val
    }
    return -1
}