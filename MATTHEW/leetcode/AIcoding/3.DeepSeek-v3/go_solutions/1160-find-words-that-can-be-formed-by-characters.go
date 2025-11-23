func countCharacters(words []string, chars string) int {
    charCount := make([]int, 26)
    for _, c := range chars {
        charCount[c - 'a']++
    }

    total := 0
    for _, word := range words {
        tempCount := make([]int, 26)
        copy(tempCount, charCount)
        valid := true
        for _, c := range word {
            if tempCount[c - 'a'] == 0 {
                valid = false
                break
            }
            tempCount[c - 'a']--
        }
        if valid {
            total += len(word)
        }
    }
    return total
}