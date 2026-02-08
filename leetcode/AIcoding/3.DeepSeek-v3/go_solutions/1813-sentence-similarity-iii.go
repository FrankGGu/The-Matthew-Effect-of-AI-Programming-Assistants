func areSentencesSimilar(sentence1 string, sentence2 string) bool {
    words1 := strings.Fields(sentence1)
    words2 := strings.Fields(sentence2)
    n1, n2 := len(words1), len(words2)
    if n1 > n2 {
        return areSentencesSimilar(sentence2, sentence1)
    }
    i := 0
    for i < n1 && words1[i] == words2[i] {
        i++
    }
    for j := 0; j < n1 - i; j++ {
        if words1[n1 - 1 - j] != words2[n2 - 1 - j] {
            return false
        }
    }
    return true
}