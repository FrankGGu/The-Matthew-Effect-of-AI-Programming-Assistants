func putMarbles(weights []int, k int) int64 {
    n := len(weights)
    if n == 0 || k == 0 {
        return 0
    }

    pairs := make([]int, n-1)
    for i := 0; i < n-1; i++ {
        pairs[i] = weights[i] + weights[i+1]
    }

    sort.Ints(pairs)

    var maxSum, minSum int64
    for i := 0; i < k-1; i++ {
        minSum += int64(pairs[i])
        maxSum += int64(pairs[n-2-i])
    }

    return maxSum - minSum
}