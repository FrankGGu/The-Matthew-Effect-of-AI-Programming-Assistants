func spellchecker(wordlist []string, queries []string) []string {
    words := make(map[string]bool)
    lowerWords := make(map[string]string)
    vowelWords := make(map[string]string)

    for _, word := range wordlist {
        words[word] = true

        lower := strings.ToLower(word)
        if _, ok := lowerWords[lower]; !ok {
            lowerWords[lower] = word
        }

        vowel := replaceVowels(word)
        if _, ok := vowelWords[vowel]; !ok {
            vowelWords[vowel] = word
        }
    }

    result := make([]string, len(queries))
    for i, query := range queries {
        if words[query] {
            result[i] = query
            continue
        }

        lower := strings.ToLower(query)
        if word, ok := lowerWords[lower]; ok {
            result[i] = word
            continue
        }

        vowel := replaceVowels(query)
        if word, ok := vowelWords[vowel]; ok {
            result[i] = word
            continue
        }

        result[i] = ""
    }

    return result
}

func replaceVowels(s string) string {
    var sb strings.Builder
    for _, c := range strings.ToLower(s) {
        if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' {
            sb.WriteRune('*')
        } else {
            sb.WriteRune(c)
        }
    }
    return sb.String()
}