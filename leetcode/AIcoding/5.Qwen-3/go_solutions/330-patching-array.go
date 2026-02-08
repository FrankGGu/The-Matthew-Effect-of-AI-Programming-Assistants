package main

func minPatches(nums []int, n int) int {
    var patches int
    var miss int = 1
    var i int = 0
    for miss <= n {
        if i < len(nums) && nums[i] <= miss {
            miss += nums[i]
            i++
        } else {
            miss += miss
            patches++
        }
    }
    return patches
}