package main

func countSubarrays(nums []int, k int) int {
    count := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] == k {
            left := i
            right := i
            for left >= 0 && nums[left] <= k {
                left--
            }
            for right < len(nums) && nums[right] >= k {
                right++
            }
            count += (i - left) * (right - i)
        }
    }
    return count
}