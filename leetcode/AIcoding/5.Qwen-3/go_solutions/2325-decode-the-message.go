package main

func decodeMessage(key string, message string) string {
    mapping := make(map[rune]rune)
    current := 'a'
    for _, c := range key {
        if c != ' ' && mapping[c] == 0 {
            mapping[c] = current
            current++
        }
    }
    result := make([]rune, len(message))
    for i, c := range message {
        if c == ' ' {
            result[i] = ' '
        } else {
            result[i] = mapping[c]
        }
    }
    return string(result)
}