package main

func mergeSimilarItems(items1 [][]int, items2 [][]int) [][]int {
    mapItems := make(map[int]int)
    for _, item := range items1 {
        mapItems[item[0]] += item[1]
    }
    for _, item := range items2 {
        mapItems[item[0]] += item[1]
    }
    result := make([][]int, 0, len(mapItems))
    for key, value := range mapItems {
        result = append(result, []int{key, value})
    }
    return result
}