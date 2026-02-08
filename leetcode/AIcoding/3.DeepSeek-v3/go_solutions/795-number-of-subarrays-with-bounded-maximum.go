func numSubarrayBoundedMax(nums []int, left int, right int) int {
    return count(nums, right) - count(nums, left-1)
}

func count(nums []int, bound int) int {
    res, cur := 0, 0
    for _, num := range nums {
        if num <= bound {
            cur++
        } else {
            cur = 0
        }
        res += cur
    }
    return res
}