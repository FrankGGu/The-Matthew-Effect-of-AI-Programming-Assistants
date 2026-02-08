func vowelStrings(words []string, queries [][]int) []int {
    n := len(words)
    prefixSum := make([]int, n+1)

    for i, word := range words {
        if isVowelString(word) {
            prefixSum[i+1] = prefixSum[i] + 1
        } else {
            prefixSum[i+1] = prefixSum[i]
        }
    }

    result := make([]int, len(queries))
    for i, query := range queries {
        result[i] = prefixSum[query[1]+1] - prefixSum[query[0]]
    }

    return result
}

func isVowelString(word string) bool {
    vowels := "aeiou"
    return strings.ContainsRune(vowels, rune(word[0])) && strings.ContainsRune(vowels, rune(word[len(word)-1]))
}