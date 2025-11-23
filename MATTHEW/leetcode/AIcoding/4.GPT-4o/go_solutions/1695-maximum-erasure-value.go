func maximumUniqueSubarray(nums []int) int {
    n := len(nums)
    maxSum := 0
    currentSum := 0
    left := 0
    freq := make(map[int]int)

    for right := 0; right < n; right++ {
        currentSum += nums[right]
        freq[nums[right]]++

        for freq[nums[right]] > 1 {
            currentSum -= nums[left]
            freq[nums[left]]--
            left++
        }

        if currentSum > maxSum {
            maxSum = currentSum
        }
    }

    return maxSum
}