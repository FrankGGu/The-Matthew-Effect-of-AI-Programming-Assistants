import "sort"

func triangleNumber(nums []int) int {
    sort.Ints(nums)
    n := len(nums)
    res := 0
    for i := n - 1; i >= 2; i-- {
        left, right := 0, i-1
        for left < right {
            if nums[left]+nums[right] > nums[i] {
                res += right - left
                right--
            } else {
                left++
            }
        }
    }
    return res
}