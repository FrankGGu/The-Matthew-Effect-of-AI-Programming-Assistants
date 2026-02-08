func findMatrix(nums []int) [][]int {
    freq := make(map[int]int)
    maxFreq := 0
    for _, num := range nums {
        freq[num]++
        if freq[num] > maxFreq {
            maxFreq = freq[num]
        }
    }

    res := make([][]int, maxFreq)
    for num, count := range freq {
        for i := 0; i < count; i++ {
            res[i] = append(res[i], num)
        }
    }

    return res
}