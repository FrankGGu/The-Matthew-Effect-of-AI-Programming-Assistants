func maximumSum(arr []int, k int) int {
    n := len(arr)
    if n < k {
        return 0
    }

    sum := 0
    for i := 0; i < k; i++ {
        sum += arr[i]
    }

    maxSum := sum
    seen := make(map[int]int)
    for i := 0; i < k; i++ {
        seen[arr[i]]++
    }

    for i := k; i < n; i++ {
        sum += arr[i] - arr[i-k]
        seen[arr[i]]++
        seen[arr[i-k]]--

        if seen[arr[i-k]] == 0 {
            delete(seen, arr[i-k])
        }

        if len(seen) == k {
            maxSum = max(maxSum, sum)
        }
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}