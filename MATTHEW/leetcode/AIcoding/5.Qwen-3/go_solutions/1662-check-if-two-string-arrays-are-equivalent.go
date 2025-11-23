package main

func arrayStringsAreEqual(word1 []string, word2 []string) bool {
    var i, j int
    for i < len(word1) || j < len(word2) {
        if i >= len(word1) || j >= len(word2) {
            return false
        }
        if word1[i][0] != word2[j][0] {
            return false
        }
        word1[i] = word1[i][1:]
        word2[j] = word2[j][1:]
        if len(word1[i]) == 0 {
            i++
        }
        if len(word2[j]) == 0 {
            j++
        }
    }
    return true
}