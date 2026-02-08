func findMaxSequenceValue(arr []int) int {
    maxVal := arr[0]
    currentSum := 0

    for _, num := range arr {
        currentSum += num
        if currentSum > maxVal {
            maxVal = currentSum
        }
        if currentSum < 0 {
            currentSum = 0
        }
    }

    return maxVal
}