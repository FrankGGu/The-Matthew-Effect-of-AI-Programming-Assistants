func canDistribute(nums []int, quantity []int) bool {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    counts := make([]int, 0, len(freq))
    for _, count := range freq {
        counts = append(counts, count)
    }
    m := len(quantity)
    n := len(counts)
    dp := make([][]bool, n+1)
    for i := range dp {
        dp[i] = make([]bool, 1<<m)
    }
    dp[0][0] = true
    for i := 1; i <= n; i++ {
        for mask := 0; mask < (1 << m); mask++ {
            if dp[i-1][mask] {
                dp[i][mask] = true
                continue
            }
            for submask := mask; submask > 0; submask = (submask - 1) & mask {
                if dp[i-1][mask^submask] {
                    sum := 0
                    for j := 0; j < m; j++ {
                        if (submask>>j)&1 == 1 {
                            sum += quantity[j]
                        }
                    }
                    if sum <= counts[i-1] {
                        dp[i][mask] = true
                        break
                    }
                }
            }
        }
    }
    return dp[n][(1<<m)-1]
}