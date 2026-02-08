import "sort"

func minDifference(nums []int) int {
    n := len(nums)
    if n <= 4 {
        return 0
    }
    sort.Ints(nums)
    res := nums[n-1] - nums[0]
    for i := 0; i <= 3; i++ {
        res = min(res, nums[n-4+i] - nums[i])
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}