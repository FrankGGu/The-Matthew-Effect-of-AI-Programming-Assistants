func beautifulIndices(arr []int) []int {
    n := len(arr)
    if n == 0 {
        return []int{}
    }

    prefixSum := make([]int, n+1)
    for i := 1; i <= n; i++ {
        prefixSum[i] = prefixSum[i-1] + arr[i-1]
    }

    totalSum := prefixSum[n]
    result := []int{}

    for i := 0; i < n; i++ {
        if prefixSum[i] == (totalSum-prefixSum[i+1]) {
            result = append(result, i)
        }
    }

    return result
}