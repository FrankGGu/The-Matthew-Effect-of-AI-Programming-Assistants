func maximumUniqueSubarray(nums []int) int {
    n := len(nums)
    maxSum := 0
    currSum := 0
    left := 0
    seen := make(map[int]bool)

    for right := 0; right < n; right++ {
        for seen[nums[right]] {
            currSum -= nums[left]
            delete(seen, nums[left])
            left++
        }

        currSum += nums[right]
        seen[nums[right]] = true

        if currSum > maxSum {
            maxSum = currSum
        }
    }

    return maxSum
}