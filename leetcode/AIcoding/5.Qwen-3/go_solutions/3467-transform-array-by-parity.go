package main

func sortArrayByParity(nums []int) []int {
    left, right := 0, len(nums)-1
    for left < right {
        if nums[left]%2 == 0 {
            left++
        } else if nums[right]%2 == 1 {
            right--
        } else {
            nums[left], nums[right] = nums[right], nums[left]
            left++
            right--
        }
    }
    return nums
}