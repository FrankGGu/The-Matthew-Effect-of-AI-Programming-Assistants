package main

func minMovesToMakeZigzag(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return 0
    }
    res := 0
    for i := 0; i < n; i += 2 {
        if i+1 < n && nums[i] > nums[i+1] {
            res += nums[i] - nums[i+1]
        }
        if i+2 < n && nums[i] > nums[i+2] {
            res += nums[i] - nums[i+2]
        }
    }
    return res
}