func canBeTypedWords(text string, brokenLetters string) int {
    broken := make(map[rune]bool)
    for _, c := range brokenLetters {
        broken[c] = true
    }

    words := strings.Split(text, " ")
    count := 0

    for _, word := range words {
        canType := true
        for _, c := range word {
            if broken[c] {
                canType = false
                break
            }
        }
        if canType {
            count++
        }
    }

    return count
}