func spellchecker(wordlist []string, queries []string) []string {
    exactMap := make(map[string]struct{})
    vowelMap := make(map[string]string)
    vowels := "aeiou"

    for _, word := range wordlist {
        exactMap[word] = struct{}{}
        lowWord := strings.ToLower(word)
        if _, exists := vowelMap[lowWord]; !exists {
            vowelized := []rune(lowWord)
            for i, c := range vowelized {
                if strings.ContainsRune(vowels, c) {
                    vowelized[i] = 'a'
                }
            }
            vowelMap[string(vowelized)] = lowWord
        }
    }

    result := make([]string, len(queries))
    for i, query := range queries {
        if _, exists := exactMap[query]; exists {
            result[i] = query
            continue
        }

        lowQuery := strings.ToLower(query)
        if _, exists := exactMap[lowQuery]; exists {
            result[i] = lowQuery
            continue
        }

        vowelizedQuery := []rune(lowQuery)
        for i, c := range vowelizedQuery {
            if strings.ContainsRune(vowels, c) {
                vowelizedQuery[i] = 'a'
            }
        }

        if replacement, exists := vowelMap[string(vowelizedQuery)]; exists {
            result[i] = replacement
            continue
        }

        result[i] = ""
    }

    return result
}