package main

func canJump(nums []int) bool {
    n := len(nums)
    lastPos := n - 1
    for i := n - 1; i >= 0; i-- {
        if i + nums[i] >= lastPos {
            lastPos = i
        }
    }
    return lastPos == 0
}