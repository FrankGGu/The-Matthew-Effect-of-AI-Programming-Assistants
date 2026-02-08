package main

func numSubarraysWithScoreLessThanK(nums []int, k int) int {
    n := len(nums)
    left := 0
    sum := 0
    count := 0
    for right := 0; right < n; right++ {
        sum += nums[right]
        for sum >= k {
            sum -= nums[left]
            left++
        }
        count += right - left + 1
    }
    return count
}