func xSum(arr []int, k int, x int) int {
    n := len(arr)
    if n < k {
        return 0
    }

    sum := 0
    for i := 0; i < k; i++ {
        if arr[i] == x {
            sum++
        }
    }

    maxSum := sum
    for i := k; i < n; i++ {
        if arr[i] == x {
            sum++
        }
        if arr[i-k] == x {
            sum--
        }
        maxSum = max(maxSum, sum)
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}