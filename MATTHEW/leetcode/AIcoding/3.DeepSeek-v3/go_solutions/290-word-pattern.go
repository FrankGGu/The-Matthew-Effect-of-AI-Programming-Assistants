func wordPattern(pattern string, s string) bool {
    words := strings.Split(s, " ")
    if len(pattern) != len(words) {
        return false
    }

    patternToWord := make(map[byte]string)
    wordToPattern := make(map[string]byte)

    for i := 0; i < len(pattern); i++ {
        p := pattern[i]
        word := words[i]

        if val, ok := patternToWord[p]; ok {
            if val != word {
                return false
            }
        } else {
            patternToWord[p] = word
        }

        if val, ok := wordToPattern[word]; ok {
            if val != p {
                return false
            }
        } else {
            wordToPattern[word] = p
        }
    }

    return true
}