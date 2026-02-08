import "sort"

func minimumDifference(nums []int, k int) int {
    if k == 1 {
        return 0
    }
    sort.Ints(nums)
    minDiff := int(^uint(0) >> 1)
    for i := 0; i+k-1 < len(nums); i++ {
        diff := nums[i+k-1] - nums[i]
        if diff < minDiff {
            minDiff = diff
        }
    }
    return minDiff
}