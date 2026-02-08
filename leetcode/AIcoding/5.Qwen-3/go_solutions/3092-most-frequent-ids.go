package main

func mostFrequentIDs(nums []int) []int {
    freq := make(map[int]int)
    maxFreq := 0
    result := make([]int, 0, len(nums))

    for _, num := range nums {
        freq[num]++
        if freq[num] > maxFreq {
            maxFreq = freq[num]
        }
        result = append(result, maxFreq)
    }

    return result
}