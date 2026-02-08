func numberOfArrays(n int, differences []int, lower int, upper int) int {
    minSum := 0
    maxSum := 0
    currSum := 0

    for _, diff := range differences {
        currSum += diff
        if currSum < minSum {
            minSum = currSum
        }
        if currSum > maxSum {
            maxSum = currSum
        }
    }

    diff := maxSum - minSum

    count := upper - lower + 1 - diff

    if count < 0 {
        return 0
    }

    return count
}