func mergeSimilarItems(items1 [][]int, items2 [][]int) [][]int {
    itemMap := make(map[int]int)

    for _, item := range items1 {
        itemMap[item[0]] += item[1]
    }
    for _, item := range items2 {
        itemMap[item[0]] += item[1]
    }

    result := make([][]int, 0, len(itemMap))
    for key, value := range itemMap {
        result = append(result, []int{key, value})
    }

    sort.Slice(result, func(i, j int) bool {
        return result[i][0] < result[j][0]
    })

    return result
}