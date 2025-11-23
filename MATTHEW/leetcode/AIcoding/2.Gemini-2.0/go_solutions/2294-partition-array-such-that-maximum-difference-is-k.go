import "sort"

func partitionArray(nums []int, k int) int {
    sort.Ints(nums)
    count := 1
    start := nums[0]
    for i := 1; i < len(nums); i++ {
        if nums[i]-start > k {
            count++
            start = nums[i]
        }
    }
    return count
}