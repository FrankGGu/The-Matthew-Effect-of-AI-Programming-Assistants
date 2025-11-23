func countGoodSubsets(nums []int) int {
    const mod = 1_000_000_007
    cnt := make([]int, 31)
    for _, num := range nums {
        cnt[num]++
    }

    if cnt[1] > 0 {
        base := 1
        for i := 0; i < cnt[1]; i++ {
            base = (base * 2) % mod
        }
        base = (base - 1 + mod) % mod
    }

    primes := []int{2, 3, 5, 7, 11, 13, 17, 19, 23, 29}
    dp := make([]int, 1<<10)
    dp[0] = 1

    for i := 2; i <= 30; i++ {
        if cnt[i] == 0 {
            continue
        }
        mask := 0
        for j, prime := range primes {
            if i%prime == 0 {
                mask ^= 1 << j
            }
        }
        if mask == 0 {
            continue
        }
        for j := (1 << 10) - 1; j >= 0; j-- {
            if dp[j] > 0 {
                dp[j|mask] = (dp[j|mask] + dp[j]*cnt[i]) % mod
            }
        }
    }

    total := 0
    for j := 1; j < (1 << 10); j++ {
        total = (total + dp[j]) % mod
    }

    if cnt[1] > 0 {
        total = (total * base) % mod
    }

    return total
}