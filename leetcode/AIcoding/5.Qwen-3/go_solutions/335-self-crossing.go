package main

func isSelfCrossing(nums []int) bool {
    n := len(nums)
    for i := 3; i < n; i++ {
        if nums[i] >= nums[i-2] && nums[i-1] <= nums[i-3] {
            return true
        }
        if i >= 4 {
            if nums[i-1] == nums[i-3] && nums[i] + nums[i-4] >= nums[i-2] {
                return true
            }
        }
        if i >= 5 {
            if nums[i-2] >= nums[i-4] && nums[i-3] >= nums[i-1] && nums[i-1] >= nums[i-3]-nums[i-5] && nums[i] + nums[i-4] >= nums[i-2] && nums[i-1] + nums[i-5] >= nums[i-3] {
                return true
            }
        }
    }
    return false
}