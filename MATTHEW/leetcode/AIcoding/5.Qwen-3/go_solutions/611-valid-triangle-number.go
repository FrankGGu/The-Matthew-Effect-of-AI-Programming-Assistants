package main

func triangleNumber(nums []int) int {
    sort.Ints(nums)
    count := 0
    n := len(nums)
    for i := n - 1; i >= 2; i-- {
        left := 0
        right := i - 1
        for left < right {
            if nums[left]+nums[right] > nums[i] {
                count += right - left
                right--
            } else {
                left++
            }
        }
    }
    return count
}