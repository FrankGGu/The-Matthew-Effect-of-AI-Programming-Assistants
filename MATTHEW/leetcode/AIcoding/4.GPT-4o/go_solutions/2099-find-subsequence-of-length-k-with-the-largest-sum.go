func maxSubsequence(nums []int, k int) []int {
    if k == 0 {
        return []int{}
    }

    n := len(nums)
    indices := make([]int, n)
    for i := 0; i < n; i++ {
        indices[i] = i
    }

    sort.Slice(indices, func(i, j int) bool {
        return nums[indices[i]] > nums[indices[j]]
    })

    resultIndices := indices[:k]
    sort.Ints(resultIndices)

    result := make([]int, k)
    for i, idx := range resultIndices {
        result[i] = nums[idx]
    }

    return result
}