package main

func spellchecker(wordList []string, queries []string) []string {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    var solve func(string) string
    solve = func(s string) string {
        res := make([]byte, len(s))
        for i := range s {
            if vowels[s[i]] {
                res[i] = '*'
            } else {
                res[i] = s[i]
            }
        }
        return string(res)
    }

    wordSet := make(map[string]bool)
    lowerMap := make(map[string]bool)
    vowelMap := make(map[string]bool)

    for _, word := range wordList {
        wordSet[word] = true
        lower := strings.ToLower(word)
        lowerMap[lower] = true
        vowel := solve(lower)
        vowelMap[vowel] = true
    }

    result := make([]string, len(queries))
    for i, q := range queries {
        if wordSet[q] {
            result[i] = q
            continue
        }
        lowerQ := strings.ToLower(q)
        if lowerMap[lowerQ] {
            result[i] = lowerQ
            continue
        }
        vowelQ := solve(lowerQ)
        if vowelMap[vowelQ] {
            result[i] = vowelQ
        } else {
            result[i] = ""
        }
    }
    return result
}