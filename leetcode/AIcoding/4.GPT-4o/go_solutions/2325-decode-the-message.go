func decodeMessage(key string, message string) string {
    charMap := make(map[rune]rune)
    var nextRune rune = 'a'
    var result []rune

    for _, ch := range key {
        if ch != ' ' && charMap[ch] == 0 {
            charMap[ch] = nextRune
            nextRune++
        }
    }

    for _, ch := range message {
        if ch == ' ' {
            result = append(result, ' ')
        } else {
            result = append(result, charMap[ch])
        }
    }

    return string(result)
}