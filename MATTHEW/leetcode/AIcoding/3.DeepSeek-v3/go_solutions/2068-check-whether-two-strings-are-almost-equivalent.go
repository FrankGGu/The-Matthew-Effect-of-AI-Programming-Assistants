func checkAlmostEquivalent(word1 string, word2 string) bool {
    freq1 := make([]int, 26)
    freq2 := make([]int, 26)

    for _, c := range word1 {
        freq1[c - 'a']++
    }
    for _, c := range word2 {
        freq2[c - 'a']++
    }

    for i := 0; i < 26; i++ {
        if abs(freq1[i] - freq2[i]) > 3 {
            return false
        }
    }
    return true
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}