func countCompleteDayPairs(hours []int) int {
    count := 0
    modMap := make(map[int]int)
    for _, hour := range hours {
        mod := hour % 24
        complement := (24 - mod) % 24
        count += modMap[complement]
        modMap[mod]++
    }
    return count
}