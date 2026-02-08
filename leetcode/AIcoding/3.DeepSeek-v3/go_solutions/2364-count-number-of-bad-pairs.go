func countBadPairs(nums []int) int64 {
    count := make(map[int]int)
    var res int64 = 0
    n := len(nums)
    for i := 0; i < n; i++ {
        key := nums[i] - i
        res += int64(i - count[key])
        count[key]++
    }
    return res
}