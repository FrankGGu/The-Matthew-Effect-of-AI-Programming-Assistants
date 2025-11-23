func countPairs(dates []int) int {
    count := 0
    dateMap := make(map[int]int)

    for _, date := range dates {
        count += dateMap[date]
        dateMap[date]++
    }

    return count
}