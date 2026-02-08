func maximumSum(arr []int, delete int) int {
    totalSum := 0
    deleteSum := 0
    maxSum := math.MinInt32

    for _, num := range arr {
        totalSum += num
        deleteSum = max(deleteSum + num, 0)
        maxSum = max(maxSum, totalSum - deleteSum)
        if num == delete {
            totalSum = 0
            deleteSum = 0
        }
    }

    return max(maxSum, 0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}