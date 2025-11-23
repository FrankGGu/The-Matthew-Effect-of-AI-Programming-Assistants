package main

func reverseWords(s string) string {
    words := make([]string, 0)
    word := ""
    for _, c := range s {
        if c == ' ' {
            if word != "" {
                words = append(words, word)
                word = ""
            }
        } else {
            word += string(c)
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