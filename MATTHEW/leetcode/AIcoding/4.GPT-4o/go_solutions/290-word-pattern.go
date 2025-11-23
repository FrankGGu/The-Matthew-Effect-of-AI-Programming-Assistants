func wordPattern(pattern string, s string) bool {
    words := strings.Split(s, " ")
    if len(pattern) != len(words) {
        return false
    }

    charToWord := make(map[rune]string)
    wordToChar := make(map[string]rune)

    for i, char := range pattern {
        word := words[i]

        if mappedWord, exists := charToWord[char]; exists {
            if mappedWord != word {
                return false
            }
        } else {
            charToWord[char] = word
        }

        if mappedChar, exists := wordToChar[word]; exists {
            if mappedChar != char {
                return false
            }
        } else {
            wordToChar[word] = char
        }
    }

    return true
}