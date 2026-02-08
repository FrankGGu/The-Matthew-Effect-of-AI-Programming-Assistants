package main

func numSubarrayProductLessThanK(nums []int, k int) int {
    if k <= 1 {
        return 0
    }
    count := 0
    left := 0
    product := 1
    for right := 0; right < len(nums); right++ {
        product *= nums[right]
        for product >= k {
            product /= nums[left]
            left++
        }
        count += right - left + 1
    }
    return count
}