func maxDifference(nums []int) int {
    n := len(nums)

    if n <= 1 {
        return 0
    }

    maxDiff := 0

    // Helper function for absolute value
    abs := func(a int) int {
        if a < 0 {
            return -a
        }