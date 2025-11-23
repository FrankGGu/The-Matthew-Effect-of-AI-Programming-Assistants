func numberOfSubarrays(nums []int, k int) int {
    // Helper function to count subarrays with at most `k` odd numbers.
    // This is a standard sliding window approach.
    countAtMost := func(k int) int {
        left := 0
        oddCount := 0
        result := 0