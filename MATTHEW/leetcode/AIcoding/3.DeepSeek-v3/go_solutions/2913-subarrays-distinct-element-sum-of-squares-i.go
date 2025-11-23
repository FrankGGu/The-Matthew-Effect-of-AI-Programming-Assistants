func sumCounts(nums []int) int {
    n := len(nums)
    total := 0
    for i := 0; i < n; i++ {
        distinct := make(map[int]bool)
        count := 0
        for j := i; j < n; j++ {
            if !distinct[nums[j]] {
                distinct[nums[j]] = true
                count++
            }
            total += count * count
        }
    }
    return total
}