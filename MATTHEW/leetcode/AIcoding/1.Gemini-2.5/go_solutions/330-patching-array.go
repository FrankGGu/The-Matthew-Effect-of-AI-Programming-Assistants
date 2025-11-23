func minPatches(nums []int, n int) int {
    patches := 0
    var miss int64 = 1 
    i := 0 

    for miss <= int64(n) {
        if i < len(nums) && int64(nums[i]) <= miss {
            miss += int64(nums[i])
            i++
        } else {
            miss += miss 
            patches++
        }
    }

    return patches
}