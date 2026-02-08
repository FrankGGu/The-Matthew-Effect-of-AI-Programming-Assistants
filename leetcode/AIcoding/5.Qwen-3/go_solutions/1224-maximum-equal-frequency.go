package main

func maxEqualFreq(nums []int) int {
    freq := make(map[int]int)
    count := make(map[int]int)
    maxFreq := 0
    for _, num := range nums {
        freq[num]++
        count[freq[num]]++
        if freq[num] > maxFreq {
            maxFreq = freq[num]
        }
    }
    if maxFreq == 1 || len(freq) == 1 {
        return len(nums)
    }
    for i := len(nums); i > 0; i-- {
        if (i%len(freq) == 0 && maxFreq == i/len(freq)) || (i%len(freq) == 1 && maxFreq == i/len(freq)+1) {
            return i
        }
    }
    return 1
}