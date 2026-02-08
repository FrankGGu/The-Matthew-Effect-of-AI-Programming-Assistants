func minPatches(nums []int, n int) int {
    patches := 0
    x := 1
    i := 0
    for x <= n {
        if i < len(nums) && nums[i] <= x {
            x += nums[i]
            i++
        } else {
            patches++
            x += x
        }
    }
    return patches
}