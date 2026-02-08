func reversePrefix(word string, ch byte) string {
    index := strings.IndexByte(word, ch)
    if index == -1 {
        return word
    }
    prefix := word[:index+1]
    reversedPrefix := reverseString(prefix)
    return reversedPrefix + word[index+1:]
}

func reverseString(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}