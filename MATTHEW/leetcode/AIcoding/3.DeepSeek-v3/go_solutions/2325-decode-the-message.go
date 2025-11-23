func decodeMessage(key string, message string) string {
    substitution := make(map[rune]byte)
    current := byte('a')
    for _, c := range key {
        if c != ' ' && substitution[c] == 0 {
            substitution[c] = current
            current++
        }
    }

    decoded := make([]byte, len(message))
    for i, c := range message {
        if c == ' ' {
            decoded[i] = ' '
        } else {
            decoded[i] = substitution[c]
        }
    }
    return string(decoded)
}