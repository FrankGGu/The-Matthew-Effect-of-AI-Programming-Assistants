package main

func partitionArray(nums []int, pivot int) []int {
    left := 0
    right := len(nums) - 1

    for left < right {
        for left < right && nums[left] < pivot {
            left++
        }
        for left < right && nums[right] > pivot {
            right--
        }
        if left < right {
            nums[left], nums[right] = nums[right], nums[left]
            left++
            right--
        }
    }

    return nums
}