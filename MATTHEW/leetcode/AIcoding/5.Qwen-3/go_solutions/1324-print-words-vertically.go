package main

func printWordsVertically(s string) []string {
    words := make([]string, 0)
    word := ""
    for _, ch := range s {
        if ch == ' ' {
            words = append(words, word)
            word = ""
        } else {
            word += string(ch)
        }
    }
    words = append(words, word)

    maxLen := 0
    for _, word := range words {
        if len(word) > maxLen {
            maxLen = len(word)
        }
    }

    result := make([]string, maxLen)
    for i := 0; i < maxLen; i++ {
        vertical := ""
        for j := 0; j < len(words); j++ {
            if i < len(words[j]) {
                vertical += string(words[j][i])
            } else {
                vertical += " "
            }
        }
        result[i] = vertical
    }

    return result
}