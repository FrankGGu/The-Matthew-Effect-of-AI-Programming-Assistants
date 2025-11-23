func countWords(words1 []string, words2 []string, letters []string) int {
    count := 0
    wordMap1 := make(map[string]int)
    wordMap2 := make(map[string]int)

    for _, word := range words1 {
        wordMap1[word]++
    }

    for _, word := range words2 {
        wordMap2[word]++
    }

    letterCount := make(map[rune]int)
    for _, letter := range letters {
        letterCount[rune(letter[0])]++
    }

    for word, count1 := range wordMap1 {
        if count2, exists := wordMap2[word]; exists && count1 == 1 && count2 == 1 {
            continue
        }
        if canFormWord(word, letterCount) {
            count++
        }
    }

    return count
}

func canFormWord(word string, letterCount map[rune]int) bool {
    tempCount := make(map[rune]int)
    for _, char := range word {
        tempCount[char]++
        if tempCount[char] > letterCount[char] {
            return false
        }
    }
    return true
}