func countCharacters(words []string, chars string) int {
    charCount := make(map[rune]int)
    for _, ch := range chars {
        charCount[ch]++
    }

    totalLength := 0
    for _, word := range words {
        wordCount := make(map[rune]int)
        for _, ch := range word {
            wordCount[ch]++
        }

        canForm := true
        for ch, count := range wordCount {
            if count > charCount[ch] {
                canForm = false
                break
            }
        }

        if canForm {
            totalLength += len(word)
        }
    }

    return totalLength
}