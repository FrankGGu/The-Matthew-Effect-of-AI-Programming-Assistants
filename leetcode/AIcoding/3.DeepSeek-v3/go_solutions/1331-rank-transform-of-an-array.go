func arrayRankTransform(arr []int) []int {
    if len(arr) == 0 {
        return arr
    }
    sortedArr := make([]int, len(arr))
    copy(sortedArr, arr)
    sort.Ints(sortedArr)

    rankMap := make(map[int]int)
    rank := 1
    for i := 0; i < len(sortedArr); i++ {
        if _, exists := rankMap[sortedArr[i]]; !exists {
            rankMap[sortedArr[i]] = rank
            rank++
        }
    }

    result := make([]int, len(arr))
    for i := 0; i < len(arr); i++ {
        result[i] = rankMap[arr[i]]
    }
    return result
}