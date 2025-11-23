package main

func reverseWords(s string) string {
    words := make([]string, 0)
    word := ""
    for _, ch := range s {
        if ch == ' ' {
            if word != "" {
                words = append(words, word)
                word = ""
            }
        } else {
            word += string(ch)
        }
    }
    if word != "" {
        words = append(words, word)
    }
    for i, j := 0, len(words)-1; i < j; i, j = i+1, j-1 {
        words[i], words[j] = words[j], words[i]
    }
    return strings.Join(words, " ")
}