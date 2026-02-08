func mostFrequentItemCount(collection []int) int {
    countMap := make(map[int]int)
    for _, item := range collection {
        countMap[item]++
    }

    maxCount := 0
    for _, count := range countMap {
        if count > maxCount {
            maxCount = count
        }
    }

    return maxCount
}