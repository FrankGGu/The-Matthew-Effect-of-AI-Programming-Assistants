import "sort"

func countPairs(nums []int, target int) int {
    sort.Ints(nums)
    count := 0
    left := 0
    right := len(nums) - 1

    for left < right {
        if nums[left]+nums[right] < target {
            //