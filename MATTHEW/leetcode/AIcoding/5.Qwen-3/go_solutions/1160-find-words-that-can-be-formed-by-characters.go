package main

func countCharacters(words []string, chars string) int {
    charCount := make([]int, 26)
    for _, c := range chars {
        charCount[c-'a']++
    }

    total := 0

    for _, word := range words {
        wordCount := make([]int, 26)
        valid := true
        for _, c := range word {
            wordCount[c-'a']++
            if wordCount[c-'a'] > charCount[c-'a'] {
                valid = false
                break
            }
        }
        if valid {
            total += len(word)
        }
    }

    return total
}