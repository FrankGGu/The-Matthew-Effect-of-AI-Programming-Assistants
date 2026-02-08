func maxEqualFreq(nums []int) int {
    freq := make(map[int]int)
    count := make(map[int]int)
    res := 0
    maxFreq := 0

    for i, num := range nums {
        if count[num] > 0 {
            freq[count[num]]--
        }
        count[num]++
        freq[count[num]]++
        if count[num] > maxFreq {
            maxFreq = count[num]
        }
        if maxFreq == 1 ||
            (freq[maxFreq] == 1 && freq[maxFreq-1]*(maxFreq-1) == i) ||
            (freq[1] == 1 && freq[maxFreq]*maxFreq == i) {
            res = i + 1
        }
    }
    return res
}