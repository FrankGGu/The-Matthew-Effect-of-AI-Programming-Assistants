func countMonotonicPairs(nums []int) int {
    n := len(nums)
    if n < 2 {
        return 0
    }

    increasingCount := 0
    decreasingCount := 0

    for i := 1; i < n; i++ {
        if nums[i] > nums[i-1] {
            increasingCount++
        } else if nums[i] < nums[i-1] {
            decreasingCount++
        }
    }

    return increasingCount + decreasingCount
}