func replaceWords(dict []string, sentence string) string {
    rootSet := make(map[string]struct{})
    for _, root := range dict {
        rootSet[root] = struct{}{}
    }

    words := strings.Split(sentence, " ")
    for i, word := range words {
        for j := 1; j <= len(word); j++ {
            if _, exists := rootSet[word[:j]]; exists {
                words[i] = word[:j]
                break
            }
        }
    }

    return strings.Join(words, " ")
}