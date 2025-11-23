type TrieNode struct {
    children [26]*TrieNode
    count    int
}

func sumPrefixScores(words []string) []int {
    root := &TrieNode{}
    for _, word := range words {
        node := root
        for _, c := range word {
            idx := c - 'a'
            if node.children[idx] == nil {
                node.children[idx] = &TrieNode{}
            }
            node = node.children[idx]
            node.count++
        }
    }

    res := make([]int, len(words))
    for i, word := range words {
        node := root
        score := 0
        for _, c := range word {
            idx := c - 'a'
            node = node.children[idx]
            score += node.count
        }
        res[i] = score
    }
    return res
}