func numSmallerByFrequency(queries []string, words []string) []int {
    wordCounts := make([]int, len(words))
    for i, word := range words {
        wordCounts[i] = f(word)
    }
    sort.Ints(wordCounts)

    res := make([]int, len(queries))
    for i, query := range queries {
        cnt := f(query)
        idx := sort.Search(len(wordCounts), func(j int) bool {
            return wordCounts[j] > cnt
        })
        res[i] = len(wordCounts) - idx
    }
    return res
}

func f(s string) int {
    minChar := 'z'
    count := 0
    for _, c := range s {
        if c < minChar {
            minChar = c
            count = 1
        } else if c == minChar {
            count++
        }
    }
    return count
}