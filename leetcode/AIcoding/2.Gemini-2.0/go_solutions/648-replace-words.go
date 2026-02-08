func replaceWords(dictionary []string, sentence string) string {
    root := &trieNode{}
    for _, word := range dictionary {
        curr := root
        for _, char := range word {
            idx := char - 'a'
            if curr.children[idx] == nil {
                curr.children[idx] = &trieNode{}
            }
            curr = curr.children[idx]
        }
        curr.isWord = true
    }

    words := strings.Split(sentence, " ")
    for i, word := range words {
        prefix := findPrefix(word, root)
        if prefix != "" {
            words[i] = prefix
        }
    }

    return strings.Join(words, " ")
}

type trieNode struct {
    children [26]*trieNode
    isWord   bool
}

func findPrefix(word string, root *trieNode) string {
    curr := root
    prefix := ""
    for i, char := range word {
        idx := char - 'a'
        if curr.children[idx] == nil {
            return ""
        }
        curr = curr.children[idx]
        prefix += string(char)
        if curr.isWord {
            return prefix
        }
    }
    return ""
}