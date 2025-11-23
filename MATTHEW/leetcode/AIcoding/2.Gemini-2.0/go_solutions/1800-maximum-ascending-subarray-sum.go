func maxAscendingSum(nums []int) int {
    maxSum := nums[0]
    currentSum := nums[0]
    for i := 1; i < len(nums); i++ {
        if nums[i] > nums[i-1] {
            currentSum += nums[i]
        } else {
            currentSum = nums[i]
        }
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }
    return maxSum
}