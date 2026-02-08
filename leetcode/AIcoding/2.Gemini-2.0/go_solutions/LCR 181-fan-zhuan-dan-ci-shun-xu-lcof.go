func reverseWords(s string) string {
    words := []string{}
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

    result := ""
    for i, w := range words {
        result += w
        if i < len(words)-1 {
            result += " "
        }
    }
    return result
}