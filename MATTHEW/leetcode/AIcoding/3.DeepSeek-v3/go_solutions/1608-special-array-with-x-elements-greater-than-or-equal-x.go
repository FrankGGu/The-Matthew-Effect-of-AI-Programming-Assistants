func specialArray(nums []int) int {
    sort.Ints(nums)
    n := len(nums)
    for x := 0; x <= n; x++ {
        left := 0
        right := n
        for left < right {
            mid := left + (right - left) / 2
            if nums[mid] >= x {
                right = mid
            } else {
                left = mid + 1
            }
        }
        count := n - left
        if count == x {
            return x
        }
    }
    return -1
}