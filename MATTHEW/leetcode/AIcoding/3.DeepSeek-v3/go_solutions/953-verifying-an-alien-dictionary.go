func isAlienSorted(words []string, order string) bool {
    orderMap := make(map[byte]int)
    for i := 0; i < len(order); i++ {
        orderMap[order[i]] = i
    }

    for i := 0; i < len(words)-1; i++ {
        word1 := words[i]
        word2 := words[i+1]
        minLen := min(len(word1), len(word2))
        for j := 0; j < minLen; j++ {
            if word1[j] != word2[j] {
                if orderMap[word1[j]] > orderMap[word2[j]] {
                    return false
                }
                break
            }
        }
        if len(word1) > len(word2) && word1[:minLen] == word2[:minLen] {
            return false
        }
    }
    return true
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}