func arrayRankTransform(arr []int) []int {
    m := make(map[int]int)
    sortedArr := make([]int, len(arr))
    copy(sortedArr, arr)
    sort.Ints(sortedArr)

    rank := 1
    for i := 0; i < len(sortedArr); i++ {
        if i == 0 || sortedArr[i] != sortedArr[i-1] {
            m[sortedArr[i]] = rank
            rank++
        }
    }

    result := make([]int, len(arr))
    for i := 0; i < len(arr); i++ {
        result[i] = m[arr[i]]
    }

    return result
}