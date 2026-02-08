func countOperationsToEmptyArray(nums []int) int64 {
    n := len(nums)
    pos := make(map[int]int)
    for i, num := range nums {
        pos[num] = i
    }
    sorted := make([]int, n)
    copy(sorted, nums)
    sort.Ints(sorted)

    res := int64(n)
    for i := 1; i < n; i++ {
        if pos[sorted[i]] < pos[sorted[i-1]] {
            res += int64(n - i)
        }
    }
    return res
}