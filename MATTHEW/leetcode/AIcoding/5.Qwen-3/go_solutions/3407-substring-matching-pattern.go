package main

func wordPattern(pattern string, s string) bool {
    words := strings.Split(s, " ")
    if len(pattern) != len(words) {
        return false
    }
    charToWord := make(map[rune]string)
    wordToChar := make(map[string]rune)
    for i, c := range pattern {
        word := words[i]
        if w, ok := charToWord[c]; ok {
            if w != word {
                return false
            }
        } else {
            if _, ok := wordToChar[word]; ok {
                return false
            }
            charToWord[c] = word
            wordToChar[word] = c
        }
    }
    return true
}