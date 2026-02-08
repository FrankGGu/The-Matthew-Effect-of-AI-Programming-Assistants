import "sort"

func largestPerimeter(nums []int) int64 {
    sort.Slice(nums, func(i, j int) bool {
        return nums[i] < nums[j]
    })

    var currentSum int64 = 0
    var maxPerimeter int64 = -1