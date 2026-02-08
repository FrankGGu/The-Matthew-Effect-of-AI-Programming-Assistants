func maxScore(nums []int) int {
    sort.Slice(nums, func(i, j int) bool {
        return nums[i] > nums[j]
    })

    prefix := make([]int64, len(nums)+1)
    for i := 0; i < len(nums); i++ {
        prefix[i+1] = prefix[i] + int64(nums[i])
    }

    res := 0
    for i := 1; i <= len(nums); i++ {
        if prefix[i] > 0 {
            res = i
        }
    }
    return res
}