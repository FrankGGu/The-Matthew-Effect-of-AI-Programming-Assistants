func sumOfDistances(nums []int) []int {
    n := len(nums)
    indices := make(map[int][]int)
    for i, num := range nums {
        indices[num] = append(indices[num], i)
    }

    result := make([]int, n)
    for _, idxs := range indices {
        m := len(idxs)
        prefixSum := make([]int, m+1)
        for i := 0; i < m; i++ {
            prefixSum[i+1] = prefixSum[i] + idxs[i]
        }

        for i := 0; i < m; i++ {
            result[idxs[i]] = idxs[i]*i - prefixSum[i] + (prefixSum[m] - prefixSum[i+1]) - idxs[i]*(m-i-1)
        }
    }

    return result
}