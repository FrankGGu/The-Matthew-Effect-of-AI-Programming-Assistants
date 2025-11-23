func maxScore(nums []int) int {
    n := len(nums)
    dp := make([]int, 1<<n)
    for mask := 0; mask < 1<<n; mask++ {
        cnt := bits.OnesCount(uint(mask))
        if cnt%2 != 0 {
            continue
        }
        k := cnt / 2
        for i := 0; i < n; i++ {
            if mask&(1<<i) != 0 {
                continue
            }
            for j := i + 1; j < n; j++ {
                if mask&(1<<j) != 0 {
                    continue
                }
                newMask := mask | (1 << i) | (1 << j)
                score := (k + 1) * gcd(nums[i], nums[j])
                if dp[newMask] < dp[mask]+score {
                    dp[newMask] = dp[mask] + score
                }
            }
        }
    }
    return dp[(1<<n)-1]
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}