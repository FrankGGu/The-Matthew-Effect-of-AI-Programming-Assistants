func isAlienSorted(words []string, order string) bool {
    orderMap := make(map[rune]int)
    for i, ch := range order {
        orderMap[ch] = i
    }

    for i := 0; i < len(words)-1; i++ {
        if !isInOrder(words[i], words[i+1], orderMap) {
            return false
        }
    }
    return true
}

func isInOrder(word1, word2 string, orderMap map[rune]int) bool {
    minLen := min(len(word1), len(word2))
    for i := 0; i < minLen; i++ {
        if orderMap[rune(word1[i])] < orderMap[rune(word2[i])] {
            return true
        } else if orderMap[rune(word1[i])] > orderMap[rune(word2[i])] {
            return false
        }
    }
    return len(word1) <= len(word2)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}