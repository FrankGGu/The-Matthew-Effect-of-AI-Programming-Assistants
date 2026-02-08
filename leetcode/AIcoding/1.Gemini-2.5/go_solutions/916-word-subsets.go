func wordSubsets(words1 []string, words2 []string) []string {
    // maxFreqB stores the maximum frequency required for each character across all words in words2.
    maxFreqB := [26]int{}

    // Calculate maxFreqB
    for _, word := range words2 {
        currentFreqB