func sumPrefixScores(words []string) []int {
    n := len(words)
    scores := make([]int, n)
    trie := make(map[string]int)

    for _, word := range words {
        prefix := ""
        for _, char := range word {
            prefix += string(char)
            trie[prefix]++
        }
    }

    for i, word := range words {
        prefix := ""
        for _, char := range word {
            prefix += string(char)
            scores[i] += trie[prefix]
        }
    }

    return scores
}