func maxSubArray(nums []int) int {
    maxSoFar := nums[0]
    maxEndingHere := nums[0]

    for i := 1; i < len(nums); i++ {
        maxEndingHere = max(nums[i], maxEndingHere + nums[i])
        maxSoFar = max(maxSoFar, maxEndingHere)
    }

    return maxSoFar
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}