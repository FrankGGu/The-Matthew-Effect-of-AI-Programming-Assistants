func lexicographicallySmallestArray(nums []int, limit int) []int {
    n := len(nums)
    indices := make([]int, n)
    for i := range indices {
        indices[i] = i
    }
    sort.Slice(indices, func(i, j int) bool {
        return nums[indices[i]] < nums[indices[j]]
    })

    res := make([]int, n)
    for i := 0; i < n; {
        j := i
        for j < n && nums[indices[j]] - nums[indices[i]] <= limit {
            j++
        }
        group := indices[i:j]
        sort.Ints(group)
        for k := i; k < j; k++ {
            res[group[k-i]] = nums[indices[k]]
        }
        i = j
    }
    return res
}