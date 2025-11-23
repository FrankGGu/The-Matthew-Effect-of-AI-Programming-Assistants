func sumImbalanceNumbers(nums []int) int {
    n := len(nums)
    res := 0
    for i := 0; i < n; i++ {
        seen := make(map[int]bool)
        seen[nums[i]] = true
        cnt := 0
        for j := i + 1; j < n; j++ {
            x := nums[j]
            if !seen[x] {
                seen[x] = true
                if seen[x-1] && seen[x+1] {
                    cnt--
                } else if !seen[x-1] && !seen[x+1] {
                    cnt++
                }
            }
            res += cnt
        }
    }
    return res
}