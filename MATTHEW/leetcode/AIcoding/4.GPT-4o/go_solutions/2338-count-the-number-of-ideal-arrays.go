func idealArrays(n int, maxValue int) int {
    const MOD = 1e9 + 7
    dp := make([]int, maxValue+1)
    for i := 1; i <= maxValue; i++ {
        dp[i] = 1
    }

    for i := 1; i <= maxValue; i++ {
        for j := 2 * i; j <= maxValue; j += i {
            dp[j] = (dp[j] + dp[i]) % MOD
        }
    }

    result := 0
    for _, v := range dp {
        result = (result + v * pow(n, MOD-2, MOD)) % MOD
    }

    return result
}

func pow(a, b, mod int) int {
    res := 1
    a = a % mod
    for b > 0 {
        if b%2 == 1 {
            res = (res * a) % mod
        }
        a = (a * a) % mod
        b /= 2
    }
    return res
}