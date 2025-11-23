import "sort"

func minIncrementForUnique(nums []int) int {
    sort.Ints(nums)

    operations := 0
    for i := 1; i < len(nums); i++ {
        if nums[i] <= nums[i-1] {
            // The current number is not strictly greater