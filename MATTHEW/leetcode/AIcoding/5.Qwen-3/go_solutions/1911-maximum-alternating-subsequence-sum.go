package main

func maxAlternatingSubsequenceSum(nums []int) int {
    up := nums[0]
    down := nums[0]
    for i := 1; i < len(nums); i++ {
        if nums[i] > up {
            down = up
            up = nums[i]
        } else if nums[i] < down {
            up = down
            down = nums[i]
        }
    }
    return max(up, down)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}