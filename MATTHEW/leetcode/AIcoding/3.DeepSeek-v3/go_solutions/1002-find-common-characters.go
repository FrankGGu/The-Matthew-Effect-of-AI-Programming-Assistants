func commonChars(words []string) []string {
    minFreq := make([]int, 26)
    for i := range minFreq {
        minFreq[i] = math.MaxInt32
    }

    for _, word := range words {
        freq := make([]int, 26)
        for _, c := range word {
            freq[c-'a']++
        }
        for i := 0; i < 26; i++ {
            if freq[i] < minFreq[i] {
                minFreq[i] = freq[i]
            }
        }
    }

    result := make([]string, 0)
    for i := 0; i < 26; i++ {
        for j := 0; j < minFreq[i]; j++ {
            result = append(result, string('a'+i))
        }
    }
    return result
}