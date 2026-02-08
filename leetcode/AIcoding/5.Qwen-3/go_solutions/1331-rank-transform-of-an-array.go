package main

func arrayRankTransform(arr []int) []int {
    if len(arr) == 0 {
        return []int{}
    }

    rankMap := make(map[int]int)
    sorted := make([]int, len(arr))
    copy(sorted, arr)
    sort.Ints(sorted)

    rank := 1
    for i := 0; i < len(sorted); i++ {
        if _, exists := rankMap[sorted[i]]; !exists {
            rankMap[sorted[i]] = rank
            rank++
        }
    }

    result := make([]int, len(arr))
    for i := 0; i < len(arr); i++ {
        result[i] = rankMap[arr[i]]
    }

    return result
}