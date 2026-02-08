type TrieNode struct {
    children [26]*TrieNode
    suggestions []string
}

func suggestedProducts(products []string, searchWord string) [][]string {
    root := &TrieNode{}
    for _, product := range products {
        insert(root, product)
    }

    res := make([][]string, 0)
    prefix := ""
    for _, c := range searchWord {
        prefix += string(c)
        res = append(res, search(root, prefix))
    }
    return res
}

func insert(root *TrieNode, word string) {
    node := root
    for _, c := range word {
        idx := c - 'a'
        if node.children[idx] == nil {
            node.children[idx] = &TrieNode{}
        }
        node = node.children[idx]
        node.suggestions = append(node.suggestions, word)
        sort.Strings(node.suggestions)
        if len(node.suggestions) > 3 {
            node.suggestions = node.suggestions[:3]
        }
    }
}

func search(root *TrieNode, prefix string) []string {
    node := root
    for _, c := range prefix {
        idx := c - 'a'
        if node.children[idx] == nil {
            return []string{}
        }
        node = node.children[idx]
    }
    return node.suggestions
}