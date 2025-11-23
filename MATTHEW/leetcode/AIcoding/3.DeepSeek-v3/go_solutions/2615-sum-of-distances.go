func distance(nums []int) []int64 {
    n := len(nums)
    res := make([]int64, n)
    indices := make(map[int][]int)

    for i, num := range nums {
        indices[num] = append(indices[num], i)
    }

    for _, group := range indices {
        m := len(group)
        if m == 1 {
            continue
        }
        prefix := make([]int64, m)
        for i := 1; i < m; i++ {
            prefix[i] = prefix[i-1] + int64(group[i] - group[i-1]) * int64(i)
        }
        suffix := make([]int64, m)
        for i := m - 2; i >= 0; i-- {
            suffix[i] = suffix[i+1] + int64(group[i+1] - group[i]) * int64(m - 1 - i)
        }
        for i := 0; i < m; i++ {
            res[group[i]] = prefix[i] + suffix[i]
        }
    }

    return res
}