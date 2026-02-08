func minimumReplacement(nums []int) int64 {
    n := len(nums)
    if n <= 1 {
        return 0
    }

    var totalReplacements int64 = 0
    currentMaxAllowed := nums[n-1] // This is the largest value the element to its left can be