func minPositiveSumSubarray(nums []int) int {
    minSum := int(^uint(0) >> 1)
    currentSum := 0
    foundPositive := false

    for _, num := range nums {
        if num > 0 {
            foundPositive = true
            currentSum += num
            if currentSum < minSum {
                minSum = currentSum
            }
        } else {
            currentSum = 0
        }
    }

    if !foundPositive {
        return 0
    }
    return minSum
}