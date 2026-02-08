func maximumSubarraySum(nums []int, k int) int64 {
    freq := make(map[int]int)
    sum := int64(0)
    maxSum := int64(0)
    left := 0

    for right := 0; right < len(nums); right++ {
        freq[nums[right]]++
        sum += int64(nums[right])

        for freq[nums[right]] > 1 || right-left+1 > k {
            freq[nums[left]]--
            sum -= int64(nums[left])
            left++
        }

        if right-left+1 == k && sum > maxSum {
            maxSum = sum
        }
    }

    return maxSum
}