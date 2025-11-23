func countNiceSubarrays(nums []int, k int) int {
    return atMost(nums, k) - atMost(nums, k-1)
}

func atMost(nums []int, k int) int {
    if k < 0 {
        return 0
    }
    left, count := 0, 0
    for right := 0; right < len(nums); right++ {
        if nums[right]%2 == 1 {
            k--
        }
        for k < 0 {
            if nums[left]%2 == 1 {
                k++
            }
            left++
        }
        count += right - left + 1
    }
    return count
}