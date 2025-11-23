package main

func reportSpamMessage(message string, bannedWords []string) bool {
    wordCount := make(map[string]int)
    for _, word := range bannedWords {
        wordCount[word]++
    }
    words := strings.Split(message, " ")
    count := 0
    for _, word := range words {
        if wordCount[word] > 0 {
            count++
            if count >= 2 {
                return true
            }
        }
    }
    return false
}