package main

func numberWays(people [][]int) int {
    const MOD = 1000000007
    hats := make([][]int, 40)
    for i, p := range people {
        for _, h := range p {
            hats[h] = append(hats[h], i)
        }
    }

    dp := make([]int, 1<<10)
    dp[0] = 1

    for h := 0; h < 40; h++ {
        for mask := 0; mask < (1 << 10); mask++ {
            dp[mask] %= MOD
        }
        for mask := 0; mask < (1 << 10); mask++ {
            if dp[mask] == 0 {
                continue
            }
            for _, p := range hats[h] {
                if (mask & (1 << p)) == 0 {
                    dp[mask|(1<<p)] = (dp[mask|(1<<p)] + dp[mask]) % MOD
                }
            }
        }
    }

    return dp[(1<<10)-1]
}