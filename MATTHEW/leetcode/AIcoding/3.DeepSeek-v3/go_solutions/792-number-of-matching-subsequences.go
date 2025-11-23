func numMatchingSubseq(s string, words []string) int {
    count := 0
    wordMap := make(map[string]int)
    for _, word := range words {
        wordMap[word]++
    }

    for word, cnt := range wordMap {
        if isSubsequence(s, word) {
            count += cnt
        }
    }
    return count
}

func isSubsequence(s string, word string) bool {
    i, j := 0, 0
    for i < len(s) && j < len(word) {
        if s[i] == word[j] {
            j++
        }
        i++
    }
    return j == len(word)
}