package main

func areSentencesSimilar(sentence1, sentence2 string) bool {
    words1 := strings.Split(sentence1, " ")
    words2 := strings.Split(sentence2, " ")

    i, j := 0, 0

    for i < len(words1) && j < len(words2) && words1[i] == words2[j] {
        i++
        j++
    }

    for i < len(words1) && j < len(words2) && words1[i] == words2[j] {
        i++
        j++
    }

    return i == len(words1) && j == len(words2)
}