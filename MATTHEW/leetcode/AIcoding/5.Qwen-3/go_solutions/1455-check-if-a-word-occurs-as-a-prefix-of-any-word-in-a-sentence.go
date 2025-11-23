package main

func isPrefixOfWord(sentence string, searchWord string) int {
    words := strings.Split(sentence, " ")
    for i, word := range words {
        if len(word) >= len(searchWord) && word[:len(searchWord)] == searchWord {
            return i + 1
        }
    }
    return -1
}