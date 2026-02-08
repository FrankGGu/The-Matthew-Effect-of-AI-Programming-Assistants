package main

func gcdOfStrings(word1 string, word2 string) string {
    if len(word1)+len(word2) == 0 {
        return ""
    }
    if len(word1) < len(word2) {
        word1, word2 = word2, word1
    }
    for i := len(word2); i > 0; i-- {
        if word2[:i] == word1[:i] && len(word1)%i == 0 && len(word2)%i == 0 {
            return word2[:i]
        }
    }
    return ""
}