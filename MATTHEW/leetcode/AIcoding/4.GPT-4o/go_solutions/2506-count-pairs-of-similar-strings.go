func similarPairs(words []string) int {
    count := 0
    seen := make(map[string]struct{})

    for _, word := range words {
        chars := make([]bool, 26)
        for _, ch := range word {
            chars[ch-'a'] = true
        }
        key := ""
        for i, v := range chars {
            if v {
                key += string(rune(i + 'a'))
            }
        }
        seen[key] = struct{}{}
    }

    for _, word := range words {
        chars := make([]bool, 26)
        for _, ch := range word {
            chars[ch-'a'] = true
        }
        key := ""
        for i, v := range chars {
            if v {
                key += string(rune(i + 'a'))
            }
        }
        if _, exists := seen[key]; exists {
            count++
        }
    }

    return count / 2
}