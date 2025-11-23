func minMoves(nums []int, k int) int {
    ones := []int{}
    for i, num := range nums {
        if num == 1 {
            ones = append(ones, i)
        }
    }

    m := len(ones)
    if m < k {
        return -1
    }

    prefixSum := make([]int, m+1)
    for i := 1; i <= m; i++ {
        prefixSum[i] = prefixSum[i-1] + ones[i-1]
    }

    minMoves := int(1e9)
    for i := k - 1; i < m; i++ {
        mid := (i - (k - 1)) / 2
        left := ones[i-k+1] - ones[mid]
        right := ones[mid] - ones[i-k]

        moves := (k-1)*(ones[mid]-ones[i-k]) - (prefixSum[i-k+1] - prefixSum[mid+1]) + (prefixSum[i+1] - prefixSum[mid+1]) - (k-1)*(ones[mid]-ones[i-k])
        minMoves = min(minMoves, moves)
    }

    return minMoves
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}