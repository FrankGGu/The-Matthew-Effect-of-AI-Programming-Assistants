func countAlternatingSubarrays(nums []int) int64 {
    n := len(nums)
    if n == 0 {
        return 0
    }

    var totalCount int64 = 0
    currentStreakLength := 0 // Represents the number of alternating subarrays ending at the previous index

    for i