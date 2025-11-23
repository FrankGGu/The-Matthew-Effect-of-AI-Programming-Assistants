func getDistances(arr []int) []int64 {
    n := len(arr)
    ans := make([]int64, n)

    // Map each value to a list of its indices in the original array.
    valToIndices := make(map[int][]int)
    for i, val := range arr