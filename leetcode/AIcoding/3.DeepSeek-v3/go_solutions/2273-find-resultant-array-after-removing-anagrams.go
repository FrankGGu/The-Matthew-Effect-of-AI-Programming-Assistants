func removeAnagrams(words []string) []string {
    result := []string{}
    prev := ""
    for _, word := range words {
        current := sortString(word)
        if current != prev {
            result = append(result, word)
            prev = current
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