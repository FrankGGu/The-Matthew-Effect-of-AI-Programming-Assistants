func countSubarrays(nums []int, k int) int64 {
    count := int64(0)
    n := len(nums)
    maxCount := make(map[int]int)
    left := 0

    for right := 0; right < n; right++ {
        maxCount[nums[right]]++

        for maxCount[nums[right]] >= k {
            count += int64(right - left + 1)
            maxCount[nums[left]]--
            left++
        }
    }

    return count
}