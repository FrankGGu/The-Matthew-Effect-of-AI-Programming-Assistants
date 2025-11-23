func maxSlidingWindow(nums []int, k int) []int {
    if len(nums) == 0 {
        return []int{}
    }
    var res []int
    var q []int
    for i := 0; i < len(nums); i++ {
        for len(q) > 0 && nums[i] >= nums[q[len(q)-1]] {
            q = q[:len(q)-1]
        }
        q = append(q, i)
        if q[0] <= i - k {
            q = q[1:]
        }
        if i >= k - 1 {
            res = append(res, nums[q[0]])
        }
    }
    return res
}