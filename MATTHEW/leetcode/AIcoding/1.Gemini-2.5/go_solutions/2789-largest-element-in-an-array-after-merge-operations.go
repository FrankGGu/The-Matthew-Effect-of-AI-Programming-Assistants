func largestElementAfterMergeOperations(nums []int) int64 {
    n := len(nums)
    if n == 0 {
        return 0
    }

    // Initialize current_sum with the rightmost element.
    // This current_sum will represent the largest possible sum that can be formed
    // starting from the current