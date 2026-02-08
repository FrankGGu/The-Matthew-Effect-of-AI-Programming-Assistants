func vowelStrings(words []string, queries [][]int) []int {
    isVowel := func(c byte) bool {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'
    }

    n := len(words)
    prefixSum := make([]int, n+1)

    for i := 0; i < n; i++ {
        prefixSum[i+1] = prefixSum[i]
        word := words[i]
        if len(word) > 0 && isVowel(word[0]) && isVowel(word[len(word)-1]) {
            prefixSum[i+1]++
        }
    }

    result := make([]int, len(queries))
    for i, query := range queries {
        start := query[0]
        end := query[1]
        result[i] = prefixSum[end+1] - prefixSum[start]
    }

    return result
}