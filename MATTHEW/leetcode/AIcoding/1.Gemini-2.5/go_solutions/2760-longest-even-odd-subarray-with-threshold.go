func longestEvenOddSubarray(nums []int, threshold int) int {
    maxLen := 0
    n := len(nums)

    for i := 0; i < n; {
        if nums[i]%2 == 0 && nums[i] <= threshold {
            // Found a potential start of a valid