func maximumGood(subarrays [][]int) int {
    maxSum := 0
    for _, subarray := range subarrays {
        sum := 0
        for _, value := range subarray {
            sum += value
        }
        if sum > maxSum {
            maxSum = sum
        }
    }
    return maxSum
}