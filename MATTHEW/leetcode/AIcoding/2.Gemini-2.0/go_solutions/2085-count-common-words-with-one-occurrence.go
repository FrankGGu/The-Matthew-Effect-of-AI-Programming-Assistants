func countWords(words1 []string, words2 []string) int {
    freq1 := make(map[string]int)
    freq2 := make(map[string]int)

    for _, word := range words1 {
        freq1[word]++
    }

    for _, word := range words2 {
        freq2[word]++
    }

    count := 0
    for word, freq := range freq1 {
        if freq == 1 && freq2[word] == 1 {
            count++
        }
    }

    return count
}