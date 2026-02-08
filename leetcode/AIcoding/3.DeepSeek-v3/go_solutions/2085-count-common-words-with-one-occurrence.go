func countWords(words1 []string, words2 []string) int {
    count1 := make(map[string]int)
    count2 := make(map[string]int)

    for _, word := range words1 {
        count1[word]++
    }

    for _, word := range words2 {
        count2[word]++
    }

    result := 0
    for word, cnt := range count1 {
        if cnt == 1 && count2[word] == 1 {
            result++
        }
    }
    return result
}