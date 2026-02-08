func minStartValue(nums []int) int {
    minSum := 0
    currentSum := 0

    for _, num := range nums {
        currentSum += num
        if currentSum < minSum {
            minSum = currentSum
        }
    }

    return 1 - minSum
}