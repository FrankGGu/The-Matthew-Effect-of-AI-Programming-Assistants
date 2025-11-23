package main

func maxAfterMerge(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    maxVal := nums[0]
    for i := 1; i < len(nums); i++ {
        if nums[i] > maxVal {
            maxVal = nums[i]
        } else {
            nums[i] += nums[i-1]
            if nums[i] > maxVal {
                maxVal = nums[i]
            }
        }
    }
    return maxVal
}