func wordSubsets(words1 []string, words2 []string) []string {
    bMax := make([]int, 26)
    for _, word := range words2 {
        bCount := countLetters(word)
        for i := 0; i < 26; i++ {
            if bCount[i] > bMax[i] {
                bMax[i] = bCount[i]
            }
        }
    }

    var result []string
    for _, word := range words1 {
        aCount := countLetters(word)
        universal := true
        for i := 0; i < 26; i++ {
            if aCount[i] < bMax[i] {
                universal = false
                break
            }
        }
        if universal {
            result = append(result, word)
        }
    }
    return result
}

func countLetters(s string) []int {
    count := make([]int, 26)
    for _, c := range s {
        count[c - 'a']++
    }
    return count
}