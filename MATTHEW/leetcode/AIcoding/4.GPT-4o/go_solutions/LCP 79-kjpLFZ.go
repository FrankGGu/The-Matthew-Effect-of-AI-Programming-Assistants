func maxFrequency(words []string) int {
    count := make(map[string]int)
    for _, word := range words {
        count[word]++
    }

    maxFreq := 0
    for _, freq := range count {
        if freq > maxFreq {
            maxFreq = freq
        }
    }

    return maxFreq
}