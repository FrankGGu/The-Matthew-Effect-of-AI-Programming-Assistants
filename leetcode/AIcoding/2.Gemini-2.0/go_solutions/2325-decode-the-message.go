func decodeMessage(key string, message string) string {
    mapping := make(map[rune]rune)
    current := 'a'
    for _, char := range key {
        if char != ' ' && mapping[char] == 0 {
            mapping[char] = current
            current++
        }
    }

    result := ""
    for _, char := range message {
        if char == ' ' {
            result += " "
        } else {
            result += string(mapping[char])
        }
    }
    return result
}