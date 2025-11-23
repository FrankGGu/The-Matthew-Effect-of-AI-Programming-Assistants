func maxNumOfMarkedIndices(nums []int) int {
    sort.Ints(nums)
    n := len(nums)
    res := 0
    j := n / 2
    for i := 0; i < n/2; i++ {
        for j < n && nums[i]*2 > nums[j] {
            j++
        }
        if j < n {
            res += 2
            j++
        }
    }
    return res
}