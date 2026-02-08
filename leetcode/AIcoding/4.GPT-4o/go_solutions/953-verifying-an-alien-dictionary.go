func isAlienSorted(words []string, order string) bool {
    orderMap := make(map[rune]int)
    for i, char := range order {
        orderMap[char] = i
    }

    for i := 0; i < len(words)-1; i++ {
        if !compare(words[i], words[i+1], orderMap) {
            return false
        }
    }

    return true
}

func compare(word1, word2 string, orderMap map[rune]int) bool {
    minLen := min(len(word1), len(word2))
    for i := 0; i < minLen; i++ {
        if word1[i] != word2[i] {
            return orderMap[rune(word1[i])] < orderMap[rune(word2[i])]
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