func minimumOperationsToMakeKPeriodic(word string, k int) int {
    n := len(word)
    freq := make(map[string]int)
    maxFreq := 0

    for i := 0; i <= n-k; i += k {
        segment := word[i : i+k]
        freq[segment]++
        if freq[segment] > maxFreq {
            maxFreq = freq[segment]
        }
    }

    return (n / k) - maxFreq
}