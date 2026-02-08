func distinctAverages(nums []int) int {
    sort.Ints(nums)
    seen := make(map[float64]struct{})
    n := len(nums)

    for i := 0; i < n/2; i++ {
        avg := float64(nums[i]+nums[n-1-i]) / 2
        seen[avg] = struct{}{}
    }

    return len(seen)
}