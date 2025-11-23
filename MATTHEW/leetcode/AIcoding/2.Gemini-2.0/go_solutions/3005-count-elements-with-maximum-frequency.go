func maxFrequencyElements(nums []int) int {
    freq := make(map[int]int)
    maxFreq := 0
    for _, num := range nums {
        freq[num]++
        if freq[num] > maxFreq {
            maxFreq = freq[num]
        }
    }

    count := 0
    for _, f := range freq {
        if f == maxFreq {
            count++
        }
    }

    return count * maxFreq
}