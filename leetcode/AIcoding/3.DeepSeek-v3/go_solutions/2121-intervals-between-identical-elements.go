func getDistances(arr []int) []int64 {
    n := len(arr)
    res := make([]int64, n)
    m := make(map[int][]int)

    for i, num := range arr {
        m[num] = append(m[num], i)
    }

    for _, indices := range m {
        k := len(indices)
        prefix := make([]int64, k+1)
        for i := 0; i < k; i++ {
            prefix[i+1] = prefix[i] + int64(indices[i])
        }

        for i := 0; i < k; i++ {
            left := int64(indices[i])*int64(i) - prefix[i]
            right := (prefix[k] - prefix[i+1]) - int64(indices[i])*int64(k-1-i)
            res[indices[i]] = left + right
        }
    }

    return res
}