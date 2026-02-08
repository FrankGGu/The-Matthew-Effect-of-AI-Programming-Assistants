package main

func numberOfGoodSubsets(nums []int) int {
    const MOD = 1e9 + 7
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    primes := []int{2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31}
    dp := make([]int, 1<<11)
    dp[0] = 1

    for num, count := range freq {
        if num == 1 {
            continue
        }
        mask := 0
        for i, p := range primes {
            if num%p == 0 {
                mask |= 1 << i
            }
        }
        if mask == 0 {
            continue
        }
        for i := 0; i < (1 << 11); i++ {
            if (i & mask) == 0 {
                dp[i|mask] = (dp[i|mask] + dp[i]*count) % MOD
            }
        }
    }

    result := 0
    for i := 1; i < (1 << 11); i++ {
        result = (result + dp[i]) % MOD
    }

    return result
}