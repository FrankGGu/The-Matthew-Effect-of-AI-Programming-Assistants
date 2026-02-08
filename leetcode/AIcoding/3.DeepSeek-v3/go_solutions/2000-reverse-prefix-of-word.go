func reversePrefix(word string, ch byte) string {
    index := strings.IndexByte(word, ch)
    if index == -1 {
        return word
    }
    runes := []rune(word)
    for i, j := 0, index; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}