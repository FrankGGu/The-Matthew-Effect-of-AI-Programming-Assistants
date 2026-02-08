package main

func mergeAlternately(word1 string, word2 string) string {
    var result []rune
    i := 0
    for i < len(word1) && i < len(word2) {
        result = append(result, rune(word1[i]))
        result = append(result, rune(word2[i]))
        i++
    }
    if i < len(word1) {
        result = append(result, []rune(word1[i:])...)
    } else if i < len(word2) {
        result = append(result, []rune(word2[i:])...)
    }
    return string(result)
}