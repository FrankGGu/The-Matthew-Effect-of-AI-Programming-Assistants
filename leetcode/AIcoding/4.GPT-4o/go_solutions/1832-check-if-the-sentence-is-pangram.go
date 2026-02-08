func checkIfPangram(sentence string) bool {
    charMap := make(map[rune]bool)
    for _, char := range sentence {
        charMap[char] = true
    }
    return len(charMap) >= 26
}