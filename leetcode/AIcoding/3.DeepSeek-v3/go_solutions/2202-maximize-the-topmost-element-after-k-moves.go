func maximumTop(nums []int, k int) int {
    n := len(nums)
    if n == 1 {
        if k%2 == 1 {
            return -1
        }
        return nums[0]
    }
    max := -1
    for i := 0; i < n && i <= k; i++ {
        if i == k-1 {
            continue
        }
        if nums[i] > max {
            max = nums[i]
        }
    }
    return max
}