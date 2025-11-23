func mergeSimilarItems(items1 [][]int, items2 [][]int) [][]int {
    valueMap := make(map[int]int)

    for _, item := range items1 {
        value := item[0]
        weight := item[1]
        valueMap[value] += weight
    }

    for _, item := range items2 {
        value := item[0]
        weight := item[1]
        valueMap[value] += weight
    }

    keys := make([]int, 0, len(valueMap))
    for k := range valueMap {
        keys = append(keys, k)
    }
    sort.Ints(keys)

    result := make([][]int, len(keys))
    for i, k := range keys {
        result[i] = []int{k, valueMap[k]}
    }

    return result
}