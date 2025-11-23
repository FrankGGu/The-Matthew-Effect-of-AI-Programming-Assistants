import "sort"

func distinctAverages(nums []int) int {
    sort.Ints(nums)
    seen := make(map[float64]bool)
    left, right := 0, len(nums)-1
    for left <= right {
        avg := float64(nums[left] + nums[right]) / 2.0
        seen[avg] = true
        left++
        right--
    }
    return len(seen)
}