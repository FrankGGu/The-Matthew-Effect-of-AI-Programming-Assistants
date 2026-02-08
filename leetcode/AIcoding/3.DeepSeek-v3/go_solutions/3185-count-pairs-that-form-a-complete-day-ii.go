func countCompleteDayPairs(hours []int) int64 {
    freq := make(map[int]int64)
    var count int64
    for _, h := range hours {
        mod := h % 24
        complement := (24 - mod) % 24
        count += freq[complement]
        freq[mod]++
    }
    return count
}