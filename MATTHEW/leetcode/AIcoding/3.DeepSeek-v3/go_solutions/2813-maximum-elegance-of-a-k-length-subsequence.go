func findMaximumElegance(items [][]int, k int) int64 {
    sort.Slice(items, func(i, j int) bool {
        return items[i][0] > items[j][0]
    })

    res := 0
    sum := 0
    categoryMap := make(map[int]int)
    duplicates := make([]int, 0)

    for i := 0; i < k; i++ {
        sum += items[i][0]
        category := items[i][1]
        if count, exists := categoryMap[category]; exists {
            duplicates = append(duplicates, items[i][0])
        }
        categoryMap[category]++
    }

    res = sum + len(categoryMap)*len(categoryMap)

    for i := k; i < len(items) && len(duplicates) > 0; i++ {
        category := items[i][1]
        if _, exists := categoryMap[category]; !exists {
            sum = sum - duplicates[len(duplicates)-1] + items[i][0]
            duplicates = duplicates[:len(duplicates)-1]
            categoryMap[category] = 1
            current := sum + len(categoryMap)*len(categoryMap)
            if current > res {
                res = current
            }
        }
    }

    return int64(res)
}