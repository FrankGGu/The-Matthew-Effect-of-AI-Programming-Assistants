func findLargestElement(nums []int, k int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    sort.Ints(nums)
    for k > 0 && n > 1 {
        nums[n-2] += nums[n-1]
        n--
        k--
        sort.Ints(nums[:n])
    }

    return nums[n-1]
}