type WordFilter struct {
    trie map[string]int
}

func Constructor(words []string) WordFilter {
    wf := WordFilter{trie: make(map[string]int)}
    for i, word := range words {
        for j := 0; j <= len(word); j++ {
            wf.trie[word[:j]] = i
        }
        for j := 0; j <= len(word); j++ {
            wf.trie[word[len(word)-j:]] = i
        }
    }
    return wf
}

func (this *WordFilter) F(prefix string, suffix string) int {
    key := prefix + "#" + suffix
    if idx, exists := this.trie[key]; exists {
        return idx
    }
    return -1
}