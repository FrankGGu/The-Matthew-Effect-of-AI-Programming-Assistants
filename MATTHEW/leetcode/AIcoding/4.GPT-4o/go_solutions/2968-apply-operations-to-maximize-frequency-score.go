func maximizeFrequencyScore(nums []int, k int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    freqScore := 0
    for num, count := range freq {
        freqScore += count * count
    }

    for num := range freq {
        if count, exists := freq[num+k]; exists {
            freqScore -= freq[num] * freq[num]
            freqScore += (freq[num] + freq[num+k]) * (freq[num] + freq[num+k])
        }
    }

    return freqScore
}