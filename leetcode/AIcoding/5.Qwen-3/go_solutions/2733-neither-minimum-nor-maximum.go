package main

func findNonMinOrMax(nums []int) int {
    for i := 0; i < len(nums); i++ {
        if nums[i] != min(nums) && nums[i] != max(nums) {
            return nums[i]
        }
    }
    return -1
}

func min(nums []int) int {
    m := nums[0]
    for _, num := range nums {
        if num < m {
            m = num
        }
    }
    return m
}

func max(nums []int) int {
    m := nums[0]
    for _, num := range nums {
        if num > m {
            m = num
        }
    }
    return m
}