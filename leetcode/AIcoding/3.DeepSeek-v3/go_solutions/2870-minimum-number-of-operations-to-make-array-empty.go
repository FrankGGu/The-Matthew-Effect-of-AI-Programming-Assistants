func minOperations(nums []int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    res := 0
    for _, count := range freq {
        if count == 1 {
            return -1
        }
        res += count / 3
        if count%3 != 0 {
            res++
        }
    }
    return res
}