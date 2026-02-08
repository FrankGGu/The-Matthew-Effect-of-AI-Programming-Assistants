func minimumRightShifts(nums []int) int {
    n := len(nums)
    pivot := 0
    for i := 1; i < n; i++ {
        if nums[i-1] > nums[i] {
            pivot = i
            break
        }
    }
    if pivot == 0 {
        return 0
    }
    for i := pivot + 1; i < n; i++ {
        if nums[i-1] > nums[i] {
            return -1
        }
    }
    if nums[n-1] <= nums[0] {
        return n - pivot
    }
    return -1
}