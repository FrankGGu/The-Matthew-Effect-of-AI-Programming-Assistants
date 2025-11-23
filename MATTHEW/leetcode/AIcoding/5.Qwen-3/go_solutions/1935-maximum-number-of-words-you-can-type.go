package main

func canBeTypedWords(text string, brokenLetters string) int {
    broken := make(map[rune]bool)
    for _, c := range brokenLetters {
        broken[c] = true
    }
    words := 0
    word := ""
    for _, c := range text {
        if c == ' ' {
            if len(word) > 0 {
                valid := true
                for _, ch := range word {
                    if broken[ch] {
                        valid = false
                        break
                    }
                }
                if valid {
                    words++
                }
                word = ""
            }
        } else {
            word += string(c)
        }
    }
    if len(word) > 0 {
        valid := true
        for _, ch := range word {
            if broken[ch] {
                valid = false
                break
            }
        }
        if valid {
            words++
        }
    }
    return words
}