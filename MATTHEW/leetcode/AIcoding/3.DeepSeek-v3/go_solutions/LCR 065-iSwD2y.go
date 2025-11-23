type TrieNode struct {
    children [26]*TrieNode
}

func minimumLengthEncoding(words []string) int {
    root := &TrieNode{}
    leaves := []*TrieNode{}
    uniqueWords := make(map[string]bool)

    for _, word := range words {
        if !uniqueWords[word] {
            uniqueWords[word] = true
            current := root
            for i := len(word) - 1; i >= 0; i-- {
                ch := word[i] - 'a'
                if current.children[ch] == nil {
                    current.children[ch] = &TrieNode{}
                }
                current = current.children[ch]
            }
            leaves = append(leaves, current)
        }
    }

    res := 0
    for i, node := range leaves {
        isLeaf := true
        for _, child := range node.children {
            if child != nil {
                isLeaf = false
                break
            }
        }
        if isLeaf {
            res += len(words[i]) + 1
        }
    }
    return res
}