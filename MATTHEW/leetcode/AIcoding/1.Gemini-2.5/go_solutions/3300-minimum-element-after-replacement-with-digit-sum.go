func minimumReplacement(nums []int) int64 {
    n := len(nums)
    if n <= 1 {
        return 0
    }

    var operations int64 = 0

    // Start from the second to last element and iterate backwards
    // `maxAllowed` represents the maximum value the current element