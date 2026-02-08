func maximumSum(arr []int) int {
    n := len(arr)
    maxSum := arr[0]
    maxEndHere := arr[0]
    maxEndHereWithDelete := 0

    for i := 1; i < n; i++ {
        maxEndHere = max(arr[i], maxEndHere + arr[i])
        maxEndHereWithDelete = max(maxEndHereWithDelete + arr[i], maxEndHere)
        maxSum = max(maxSum, max(maxEndHere, maxEndHereWithDelete))
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}