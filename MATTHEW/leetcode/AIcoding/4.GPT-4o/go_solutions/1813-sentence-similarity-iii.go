func areSentencesSimilar(sentence1 []string, sentence2 []string, similarPairs [][]string) bool {
    if len(sentence1) < len(sentence2) {
        return areSentencesSimilar(sentence2, sentence1, similarPairs)
    }
    if len(sentence1) == len(sentence2) {
        return checkSimilarity(sentence1, sentence2, similarPairs)
    }
    for i := 0; i <= len(sentence1)-len(sentence2); i++ {
        if checkSimilarity(sentence1[i:], sentence2, similarPairs) {
            return true
        }
    }
    return false
}

func checkSimilarity(s1 []string, s2 []string, similarPairs [][]string) bool {
    if len(s1) != len(s2) {
        return false
    }
    simMap := make(map[string]map[string]bool)
    for _, pair := range similarPairs {
        if _, ok := simMap[pair[0]]; !ok {
            simMap[pair[0]] = make(map[string]bool)
        }
        simMap[pair[0]][pair[1]] = true
        if _, ok := simMap[pair[1]]; !ok {
            simMap[pair[1]] = make(map[string]bool)
        }
        simMap[pair[1]][pair[0]] = true
    }
    for i := 0; i < len(s1); i++ {
        if s1[i] != s2[i] && !isSimilar(s1[i], s2[i], simMap) {
            return false
        }
    }
    return true
}

func isSimilar(word1 string, word2 string, simMap map[string]map[string]bool) bool {
    if _, ok := simMap[word1]; ok {
        return simMap[word1][word2]
    }
    return word1 == word2
}