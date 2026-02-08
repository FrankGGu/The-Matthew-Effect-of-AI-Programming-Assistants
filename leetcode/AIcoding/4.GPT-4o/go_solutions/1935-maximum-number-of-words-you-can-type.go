func canBeTypedWords(text string, brokenLetters string) int {
    brokenSet := make(map[rune]struct{})
    for _, ch := range brokenLetters {
        brokenSet[ch] = struct{}{}
    }

    words := strings.Split(text, " ")
    count := 0

    for _, word := range words {
        canType := true
        for _, ch := range word {
            if _, exists := brokenSet[ch]; exists {
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