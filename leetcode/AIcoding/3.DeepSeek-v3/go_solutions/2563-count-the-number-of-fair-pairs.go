func countFairPairs(nums []int, lower int, upper int) int64 {
    sort.Ints(nums)
    var count int64
    n := len(nums)
    for i := 0; i < n; i++ {
        left := lower - nums[i]
        right := upper - nums[i]
        l := sort.SearchInts(nums, left)
        r := sort.SearchInts(nums, right+1)
        if r > i {
            r = i
        }
        if l < r {
            count += int64(r - l)
        }
    }
    return count
}