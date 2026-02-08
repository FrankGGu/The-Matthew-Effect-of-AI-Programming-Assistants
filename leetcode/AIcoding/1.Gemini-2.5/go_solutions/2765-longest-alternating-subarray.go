func longestAlternatingSubarray(nums []int, threshold int) int {
    maxLength := 0
    n := len(nums)
    i := 0

    for i < n {
        if nums[i] <= threshold && nums[i]%2 == 0 {
            // Found a potential start of an alternating