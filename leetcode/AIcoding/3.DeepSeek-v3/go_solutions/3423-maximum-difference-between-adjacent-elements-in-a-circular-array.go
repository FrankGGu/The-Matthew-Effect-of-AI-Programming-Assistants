func maxDifferenceCircular(nums []int) int {
    n := len(nums)
    maxDiff := -1
    for i := 0; i < n; i++ {
        for j := 1; j < n; j++ {
            next := (i + j) % n
            if nums[i] < nums[next] {
                diff := nums[next] - nums[i]
                if diff > maxDiff {
                    maxDiff = diff
                }
            }
        }
    }
    return maxDiff
}