func findKDistantIndices(nums []int, key int, k int) []int {
    var result []int
    n := len(nums)

    for i := 0; i < n; i++ {
        if nums[i] == key {
            for j := max(0, i-k); j <= min(n-1, i+k); j++ {
                result = append(result, j)
            }
        }
    }

    unique := make(map[int]struct{})
    for _, val := range result {
        unique[val] = struct{}{}
    }

    result = result[:0]
    for key := range unique {
        result = append(result, key)
    }

    sort.Ints(result)
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}