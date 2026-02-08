func maxFrequencyAfterOperations(nums []int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    maxFreq := 0
    for _, count := range freq {
        if count > maxFreq {
            maxFreq = count
        }
    }
    return maxFreq
}