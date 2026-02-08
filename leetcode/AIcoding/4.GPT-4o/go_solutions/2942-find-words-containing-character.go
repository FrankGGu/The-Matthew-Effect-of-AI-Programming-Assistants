func findWords(words []string, chars string) []string {
    charCount := make(map[rune]int)
    for _, ch := range chars {
        charCount[ch]++
    }

    var result []string
    for _, word := range words {
        tempCount := make(map[rune]int)
        for _, ch := range word {
            tempCount[ch]++
            if tempCount[ch] > charCount[ch] {
                break
            }
        }
        if len(tempCount) == len(map[rune]int{}) {
            result = append(result, word)
        }
    }
    return result
}