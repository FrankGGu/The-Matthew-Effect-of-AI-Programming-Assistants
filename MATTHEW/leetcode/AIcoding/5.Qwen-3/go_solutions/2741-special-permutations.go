package main

func specialPermutations(house []int) int {
    n := len(house)
    dp := make([][]int, 1<<n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for i := 0; i < n; i++ {
        dp[1<<i][i] = 1
    }

    for mask := 1; mask < (1 << n); mask++ {
        for last := 0; last < n; last++ {
            if (mask & (1 << last)) == 0 {
                continue
            }
            for curr := 0; curr < n; curr++ {
                if (mask & (1 << curr)) != 0 {
                    continue
                }
                if house[curr] > house[last] {
                    dp[mask|(1<<curr)][curr] += dp[mask][last]
                }
            }
        }
    }

    result := 0
    fullMask := (1 << n) - 1
    for i := 0; i < n; i++ {
        result += dp[fullMask][i]
    }
    return result
}