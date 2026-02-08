func maximumSum(arr []int) int {
    n := len(arr)
    if n == 1 {
        return arr[0]
    }

    noDelete := make([]int, n)
    deleteOne := make([]int, n)

    noDelete[0] = arr[0]
    deleteOne[0] = 0

    maxSum := arr[0]

    for i := 1; i < n; i++ {
        noDelete[i] = max(noDelete[i-1] + arr[i], arr[i])
        deleteOne[i] = max(deleteOne[i-1] + arr[i], noDelete[i-1])
        currentMax := max(noDelete[i], deleteOne[i])
        if currentMax > maxSum {
            maxSum = currentMax
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