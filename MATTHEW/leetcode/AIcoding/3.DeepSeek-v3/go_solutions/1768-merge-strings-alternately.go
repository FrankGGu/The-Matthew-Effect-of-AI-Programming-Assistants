func mergeAlternately(word1 string, word2 string) string {
    var result []byte
    i, j := 0, 0
    for i < len(word1) && j < len(word2) {
        result = append(result, word1[i])
        result = append(result, word2[j])
        i++
        j++
    }
    for i < len(word1) {
        result = append(result, word1[i])
        i++
    }
    for j < len(word2) {
        result = append(result, word2[j])
        j++
    }
    return string(result)
}