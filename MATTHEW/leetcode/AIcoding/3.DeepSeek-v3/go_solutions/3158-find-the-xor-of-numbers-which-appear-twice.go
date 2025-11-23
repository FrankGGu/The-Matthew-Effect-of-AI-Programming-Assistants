func duplicateNumbersXOR(nums []int) int {
    freq := make(map[int]int)
    res := 0
    for _, num := range nums {
        freq[num]++
        if freq[num] == 2 {
            res ^= num
        }
    }
    return res
}