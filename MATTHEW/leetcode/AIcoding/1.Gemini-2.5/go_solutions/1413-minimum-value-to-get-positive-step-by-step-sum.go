func minStartValue(nums []int) int {
    minSum := 0
    currentSum := 0

    for _, num := range nums {
        currentSum += num
        if currentSum < minSum {
            minSum = currentSum
        }
    }

    // We need startValue + minSumOfPrefixes >= 1
    // So, startValue >= 1 - minSumOfPrefixes
    // Since startValue must be a positive integer (>= 1),
    // startValue = max(1, 1 - minSumOfPrefixes)
    return 1 - minSum
}