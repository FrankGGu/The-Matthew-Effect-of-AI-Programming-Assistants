package main

func numSubarrayAllLessThanK(nums []int, k int) int {
    count := 0
    left := 0
    for right := 0; right < len(nums); right++ {
        if nums[right] >= k {
            left = right + 1
            continue
        }
        count += right - left + 1
    }
    return count
}