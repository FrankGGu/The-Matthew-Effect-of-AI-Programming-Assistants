func mergeSimilarItems(items1 [][]int, items2 [][]int) [][]int {
    m := make(map[int]int)
    for _, item := range items1 {
        m[item[0]] += item[1]
    }
    for _, item := range items2 {
        m[item[0]] += item[1]
    }
    result := [][]int{}
    for k, v := range m {
        result = append(result, []int{k, v})
    }
    sort.Slice(result, func(i, j int) bool {
        return result[i][0] < result[j][0]
    })
    return result
}

import "sort"