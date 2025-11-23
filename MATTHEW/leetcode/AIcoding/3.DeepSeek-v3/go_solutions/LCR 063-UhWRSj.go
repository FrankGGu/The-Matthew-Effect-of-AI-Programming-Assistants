func replaceWords(dictionary []string, sentence string) string {
    roots := make(map[string]bool)
    for _, root := range dictionary {
        roots[root] = true
    }

    words := strings.Split(sentence, " ")
    for i, word := range words {
        for l := 1; l <= len(word); l++ {
            prefix := word[:l]
            if roots[prefix] {
                words[i] = prefix
                break
            }
        }
    }
    return strings.Join(words, " ")
}