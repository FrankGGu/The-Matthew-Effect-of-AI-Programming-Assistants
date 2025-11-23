func maximizeArrayValue(nums []int) int {
    n := len(nums)
    maxVal := nums[0]
    suffixSum := 0

    for i := n - 1; i >= 0; i-- {
        suffixSum += nums[i]
        currentMax := (suffixSum + i) / (i + 1)
        if currentMax > maxVal {
            maxVal = currentMax
        }
    }

    return maxVal
}