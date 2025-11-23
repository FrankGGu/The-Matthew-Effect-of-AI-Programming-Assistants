func uniqueOccurrences(arr []int) bool {
    countMap := make(map[int]int)
    for _, num := range arr {
        countMap[num]++
    }

    occurrenceSet := make(map[int]bool)
    for _, count := range countMap {
        if occurrenceSet[count] {
            return false
        }
        occurrenceSet[count] = true
    }

    return true
}