func findXSumOfAllKLongSubarrays(nums []int, k int) []int {
    n := len(nums)
    if k == 0 || k > n {
        return []int{}
    }

    result := make([]int, 0, n-k+1)

    // Calculate the sum of the first window
    currentSum := 0
    for i := 0; i < k; i++ {
        currentSum += nums[i]
    }
    result = append(result, currentSum)

    // Slide the window
    for i := k; i < n; i++ {
        currentSum = currentSum - nums[i-k] + nums[i]
        result = append(result, currentSum)
    }

    return result
}