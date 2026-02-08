func maximumUniqueSubarray(nums []int) int {
    maxSum := 0
    currentSum := 0
    left := 0
    seen := make(map[int]int)

    for right, num := range nums {
        if idx, exists := seen[num]; exists && idx >= left {
            for left <= idx {
                currentSum -= nums[left]
                left++
            }
        }
        seen[num] = right
        currentSum += num
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }

    return maxSum
}