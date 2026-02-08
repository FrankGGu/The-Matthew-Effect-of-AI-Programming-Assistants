func countGoodPairs(nums []int) int64 {
    count := int64(0)
    freq := make(map[int]int)
    for _, num := range nums {
        count += int64(freq[num])
        freq[num]++
    }
    return count
}