func findAndReplacePattern(words []string, pattern string) []string {
    var res []string
    for _, word := range words {
        if match(word, pattern) {
            res = append(res, word)
        }
    }
    return res
}

func match(word, pattern string) bool {
    if len(word) != len(pattern) {
        return false
    }
    w2p := make(map[byte]byte)
    p2w := make(map[byte]byte)
    for i := 0; i < len(word); i++ {
        w := word[i]
        p := pattern[i]
        if _, ok := w2p[w]; !ok {
            w2p[w] = p
        }
        if _, ok := p2w[p]; !ok {
            p2w[p] = w
        }
        if w2p[w] != p || p2w[p] != w {
            return false
        }
    }
    return true
}