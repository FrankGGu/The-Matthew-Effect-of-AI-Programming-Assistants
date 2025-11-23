func mostCommonWord(paragraph string, banned []string) string {
    bannedMap := make(map[string]bool)
    for _, word := range banned {
        bannedMap[word] = true
    }

    freq := make(map[string]int)
    maxFreq := 0
    var result string

    var word []rune
    for _, ch := range paragraph {
        if unicode.IsLetter(ch) {
            word = append(word, unicode.ToLower(ch))
        } else if len(word) > 0 {
            currentWord := string(word)
            if !bannedMap[currentWord] {
                freq[currentWord]++
                if freq[currentWord] > maxFreq {
                    maxFreq = freq[currentWord]
                    result = currentWord
                }
            }
            word = nil
        }
    }

    if len(word) > 0 {
        currentWord := string(word)
        if !bannedMap[currentWord] {
            freq[currentWord]++
            if freq[currentWord] > maxFreq {
                result = currentWord
            }
        }
    }

    return result
}