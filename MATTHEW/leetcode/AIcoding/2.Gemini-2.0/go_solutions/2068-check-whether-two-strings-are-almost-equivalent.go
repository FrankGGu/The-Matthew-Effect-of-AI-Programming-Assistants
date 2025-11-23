func checkAlmostEquivalent(word1 string, word2 string) bool {
    freq := make(map[rune]int)
    for _, r := range word1 {
        freq[r]++
    }
    for _, r := range word2 {
        freq[r]--
    }
    for _, v := range freq {
        if v > 3 || v < -3 {
            return false
        }
    }
    return true
}