func maxAscendingSum(nums []int) int {
    maxSum := 0
    currentSum := nums[0]

    for i := 1; i < len(nums); i++ {
        if nums[i] > nums[i-1] {
            currentSum += nums[i]
        } else {
            if currentSum > maxSum {
                maxSum = currentSum
            }
            currentSum = nums[i]
        }
    }

    if currentSum > maxSum {
        maxSum = currentSum
    }

    return maxSum
}