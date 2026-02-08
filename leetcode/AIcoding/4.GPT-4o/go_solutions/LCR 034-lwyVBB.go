func isAlienSorted(words []string, order string) bool {
    orderMap := make(map[byte]int)
    for i := 0; i < len(order); i++ {
        orderMap[order[i]] = i
    }

    for i := 0; i < len(words)-1; i++ {
        if !isInOrder(words[i], words[i+1], orderMap) {
            return false
        }
    }

    return true
}

func isInOrder(word1, word2 string, orderMap map[byte]int) bool {
    minLength := min(len(word1), len(word2))
    for i := 0; i < minLength; i++ {
        if word1[i] != word2[i] {
            return orderMap[word1[i]] < orderMap[word2[i]]
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