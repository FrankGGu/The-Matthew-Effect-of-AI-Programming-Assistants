func maximumUniqueSubarray(nums []int) int {
    numSet := make(map[int]int)
    left, maxSum, currentSum := 0, 0, 0

    for right := 0; right < len(nums); right++ {
        currentSum += nums[right]
        numSet[nums[right]]++

        for numSet[nums[right]] > 1 {
            numSet[nums[left]]--
            currentSum -= nums[left]
            left++
        }

        if currentSum > maxSum {
            maxSum = currentSum
        }
    }

    return maxSum
}