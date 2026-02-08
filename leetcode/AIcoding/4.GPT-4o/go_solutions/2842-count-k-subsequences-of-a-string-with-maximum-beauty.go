func countKSubsequences(s string, k int) int {
    const mod = 1_000_000_007
    n := len(s)
    count := make([]int, 26)
    for _, ch := range s {
        count[ch-'a']++
    }

    freq := []int{}
    for _, c := range count {
        if c > 0 {
            freq = append(freq, c)
        }
    }

    m := len(freq)
    if m < k {
        return 0
    }

    dp := make([]int, k+1)
    dp[0] = 1

    for _, f := range freq {
        for j := k; j > 0; j-- {
            for x := 1; x <= f && j-x >= 0; x++ {
                dp[j] = (dp[j] + dp[j-x]) % mod
            }
        }
    }

    return dp[k]
}