func removeAnagrams(words []string) []string {
    result := []string{}
    lastWord := ""

    for _, word := range words {
        sortedWord := sortString(word)
        if sortedWord != sortString(lastWord) {
            result = append(result, word)
            lastWord = word
        }
    }

    return result
}

func sortString(s string) string {
    runes := []rune(s)
    sort.Slice(runes, func(i, j int) bool {
        return runes[i] < runes[j]
    })
    return string(runes)
}