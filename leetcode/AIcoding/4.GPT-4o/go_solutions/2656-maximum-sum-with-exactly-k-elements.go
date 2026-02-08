func maxSum(arr []int, k int) int {
    n := len(arr)
    if n < k {
        return 0
    }

    maxSum := 0
    currentSum := 0

    for i := 0; i < k; i++ {
        currentSum += arr[i]
    }

    maxSum = currentSum

    for i := k; i < n; i++ {
        currentSum += arr[i] - arr[i-k]
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }

    return maxSum
}