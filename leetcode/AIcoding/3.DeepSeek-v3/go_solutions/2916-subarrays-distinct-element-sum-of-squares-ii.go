func sumCounts(nums []int) int {
    n := len(nums)
    mod := int(1e9 + 7)
    res := 0
    for i := 0; i < n; i++ {
        distinct := make(map[int]bool)
        count := 0
        for j := i; j < n; j++ {
            if !distinct[nums[j]] {
                distinct[nums[j]] = true
                count++
            }
            res = (res + count*count) % mod
        }
    }
    return res
}