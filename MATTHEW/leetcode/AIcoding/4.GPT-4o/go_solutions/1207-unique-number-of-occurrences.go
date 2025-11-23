func uniqueOccurrences(arr []int) bool {
    countMap := make(map[int]int)
    for _, num := range arr {
        countMap[num]++
    }

    occurrenceMap := make(map[int]bool)
    for _, count := range countMap {
        if occurrenceMap[count] {
            return false
        }
        occurrenceMap[count] = true
    }

    return true
}