func spellchecker(wordlist []string, queries []string) []string {
    exact := make(map[string]bool)
    vowel := make(map[string]string)
    cap := make(map[string]string)

    for _, word := range wordlist {
        exact[word] = true
        lower := toLower(word)
        if _, ok := cap[lower]; !ok {
            cap[lower] = word
        }
        devowel := devowel(lower)
        if _, ok := vowel[devowel]; !ok {
            vowel[devowel] = word
        }
    }

    result := make([]string, len(queries))
    for i, query := range queries {
        if _, ok := exact[query]; ok {
            result[i] = query
            continue
        }
        lower := toLower(query)
        if val, ok := cap[lower]; ok {
            result[i] = val
            continue
        }
        devowel := devowel(lower)
        if val, ok := vowel[devowel]; ok {
            result[i] = val
            continue
        }
        result[i] = ""
    }

    return result
}

func toLower(s string) string {
    result := ""
    for _, r := range s {
        if r >= 'A' && r <= 'Z' {
            result += string(r + 32)
        } else {
            result += string(r)
        }
    }
    return result
}

func devowel(s string) string {
    result := ""
    for _, r := range s {
        if r == 'a' || r == 'e' || r == 'i' || r == 'o' || r == 'u' {
            result += "*"
        } else {
            result += string(r)
        }
    }
    return result
}