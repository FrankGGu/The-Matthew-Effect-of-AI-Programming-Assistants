import "sort"

func minimumDifference(nums []int, k int) int {
    sort.Ints(nums)
    minDiff := math.MaxInt32
    for i := 0; i <= len(nums)-k; i++ {
        diff := nums[i+k-1] - nums[i]
        if diff < minDiff {
            minDiff = diff
        }
    }
    return minDiff
}