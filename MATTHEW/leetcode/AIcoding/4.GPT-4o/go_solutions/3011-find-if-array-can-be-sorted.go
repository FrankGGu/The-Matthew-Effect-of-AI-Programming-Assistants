func canBeSorted(arr []int) bool {
    n := len(arr)
    if n <= 1 {
        return true
    }

    sortedArr := make([]int, n)
    copy(sortedArr, arr)
    sort.Ints(sortedArr)

    count := 0
    for i := 0; i < n; i++ {
        if arr[i] != sortedArr[i] {
            count++
        }
    }

    return count <= 2
}