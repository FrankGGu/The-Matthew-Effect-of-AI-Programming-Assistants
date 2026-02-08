type TrieNode struct {
    children [26]*TrieNode
    isEnd    bool
}

func longestWord(words []string) string {
    root := &TrieNode{}
    for _, word := range words {
        node := root
        for _, ch := range word {
            idx := ch - 'a'
            if node.children[idx] == nil {
                node.children[idx] = &TrieNode{}
            }
            node = node.children[idx]
        }
        node.isEnd = true
    }

    var res string
    for _, word := range words {
        if len(word) < len(res) || (len(word) == len(res) && word >= res) {
            continue
        }
        node := root
        valid := true
        for _, ch := range word {
            idx := ch - 'a'
            if !node.children[idx].isEnd {
                valid = false
                break
            }
            node = node.children[idx]
        }
        if valid {
            res = word
        }
    }
    return res
}