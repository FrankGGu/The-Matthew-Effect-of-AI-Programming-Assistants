func splitWordsBySeparator(words []string, separator byte) []string {
    var result []string
    for _, word := range words {
        current := []byte{}
        for i := 0; i < len(word); i++ {
            if word[i] == separator {
                if len(current) > 0 {
                    result = append(result, string(current))
                    current = []byte{}
                }
            } else {
                current = append(current, word[i])
            }
        }
        if len(current) > 0 {
            result = append(result, string(current))
        }
    }
    return result
}