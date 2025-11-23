func uncommonFromSentences(s1 string, s2 string) []string {
    words1 := strings.Fields(s1)
    words2 := strings.Fields(s2)
    freq := make(map[string]int)

    for _, word := range words1 {
        freq[word]++
    }
    for _, word := range words2 {
        freq[word]++
    }

    var result []string
    for word, count := range freq {
        if count == 1 {
            result = append(result, word)
        }
    }

    return result
}