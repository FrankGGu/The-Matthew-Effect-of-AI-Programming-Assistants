func numMatchingSubseq(s string, words []string) int {
    count := 0
    wordMap := make(map[string]int)

    for _, word := range words {
        wordMap[word]++
    }

    for word, freq := range wordMap {
        if isSubsequence(word, s) {
            count += freq
        }
    }

    return count
}

func isSubsequence(word string, s string) bool {
    wLen, sLen := len(word), len(s)
    wIdx, sIdx := 0, 0

    for wIdx < wLen && sIdx < sLen {
        if word[wIdx] == s[sIdx] {
            wIdx++
        }
        sIdx++
    }

    return wIdx == wLen
}