func minPatches(nums []int, n int) int {
    patches := 0
    miss := 1
    i := 0
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