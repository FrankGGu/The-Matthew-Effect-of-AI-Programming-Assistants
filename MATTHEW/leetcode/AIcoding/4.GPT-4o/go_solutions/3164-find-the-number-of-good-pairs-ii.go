func countGood(nums []int) int64 {
    freq := make(map[int]int)
    var count int64
    for _, num := range nums {
        count += int64(freq[num])
        freq[num]++
    }
    return count
}