package main

func findAndReplacePattern(words []string, pattern string) []string {
    var result []string
    for _, word := range words {
        if match(word, pattern) && match(pattern, word) {
            result = append(result, word)
        }
    }
    return result
}

func match(s string, p string) bool {
    if len(s) != len(p) {
        return false
    }
    mapping := make(map[byte]byte)
    for i := 0; i < len(s); i++ {
        if val, ok := mapping[s[i]]; ok {
            if val != p[i] {
                return false
            }
        } else {
            mapping[s[i]] = p[i]
        }
    }
    return true
}