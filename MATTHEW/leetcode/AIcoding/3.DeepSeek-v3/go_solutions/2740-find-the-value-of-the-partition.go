import "sort"

func findValueOfPartition(nums []int) int {
    sort.Ints(nums)
    minDiff := nums[1] - nums[0]
    for i := 2; i < len(nums); i++ {
        diff := nums[i] - nums[i-1]
        if diff < minDiff {
            minDiff = diff
        }
    }
    return minDiff
}