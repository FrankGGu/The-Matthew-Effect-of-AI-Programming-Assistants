func minDeletion(nums []int) int {
    n := len(nums)
    res := 0
    for i := 0; i < n; {
        if i+1 < n && nums[i] == nums[i+1] {
            res++
            i++
        } else {
            i += 2
        }
    }
    if (n-res)%2 != 0 {
        res++
    }
    return res
}