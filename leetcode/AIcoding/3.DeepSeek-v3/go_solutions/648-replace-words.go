type TrieNode struct {
    children map[rune]*TrieNode
    isEnd    bool
}

func replaceWords(dictionary []string, sentence string) string {
    root := &TrieNode{children: make(map[rune]*TrieNode)}
    for _, word := range dictionary {
        node := root
        for _, ch := range word {
            if _, ok := node.children[ch]; !ok {
                node.children[ch] = &TrieNode{children: make(map[rune]*TrieNode)}
            }
            node = node.children[ch]
        }
        node.isEnd = true
    }

    words := strings.Fields(sentence)
    for i, word := range words {
        node := root
        prefix := []rune{}
        for _, ch := range word {
            if node.isEnd {
                break
            }
            if _, ok := node.children[ch]; !ok {
                prefix = nil
                break
            }
            prefix = append(prefix, ch)
            node = node.children[ch]
        }
        if len(prefix) > 0 && node.isEnd {
            words[i] = string(prefix)
        }
    }
    return strings.Join(words, " ")
}