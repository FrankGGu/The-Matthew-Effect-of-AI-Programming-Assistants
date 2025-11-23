func countDistinct(nums []int, k int, p int) int {
    n := len(nums)
    seen := make(map[string]bool)
    for i := 0; i < n; i++ {
        cnt := 0
        var sub []int
        for j := i; j < n; j++ {
            if nums[j] % p == 0 {
                cnt++
            }
            if cnt > k {
                break
            }
            sub = append(sub, nums[j])
            key := ""
            for _, num := range sub {
                key += fmt.Sprintf("%d,", num)
            }
            seen[key] = true
        }
    }
    return len(seen)
}