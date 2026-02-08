package main

func splitWordsBySeparator(words []string, separator byte) []string {
    result := []string{}
    for _, word := range words {
        var current string
        for i := 0; i < len(word); i++ {
            if word[i] == separator {
                if current != "" {
                    result = append(result, current)
                    current = ""
                }
            } else {
                current += string(word[i])
            }
        }
        if current != "" {
            result = append(result, current)
        }
    }
    return result
}