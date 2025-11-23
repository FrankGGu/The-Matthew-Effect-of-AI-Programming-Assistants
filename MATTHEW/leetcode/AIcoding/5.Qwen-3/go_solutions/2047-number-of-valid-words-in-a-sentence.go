package main

func countValidWords(sentence string) int {
    count := 0
    words := strings.Fields(sentence)
    for _, word := range words {
        valid := true
        for i, ch := range word {
            if unicode.IsDigit(ch) {
                valid = false
                break
            }
            if ch == '-' {
                if i == 0 || i == len(word)-1 || !unicode.IsLower(rune(word[i+1])) {
                    valid = false
                    break
                }
            } else if unicode.IsPunct(ch) && ch != '-' {
                valid = false
                break
            }
        }
        if valid {
            count++
        }
    }
    return count
}