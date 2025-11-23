package main

func verifyPreorder(nums []int) bool {
    var index int
    var dfs func(int) bool
    dfs = func(lower int) bool {
        if index >= len(nums) {
            return false
        }
        if nums[index] < lower {
            return false
        }
        index++
        if index < len(nums) {
            if nums[index] > nums[index-1] {
                if !dfs(nums[index-1]) {
                    return false
                }
            } else {
                if !dfs(lower) {
                    return false
                }
            }
        }
        return true
    }
    return dfs(0)
}