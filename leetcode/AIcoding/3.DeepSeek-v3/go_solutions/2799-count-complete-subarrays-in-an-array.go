func countCompleteSubarrays(nums []int) int {
    distinct := make(map[int]bool)
    for _, num := range nums {
        distinct[num] = true
    }
    k := len(distinct)
    n := len(nums)
    res := 0
    for i := 0; i < n; i++ {
        current := make(map[int]int)
        for j := i; j < n; j++ {
            current[nums[j]]++
            if len(current) == k {
                res += n - j
                break
            }
        }
    }
    return res
}