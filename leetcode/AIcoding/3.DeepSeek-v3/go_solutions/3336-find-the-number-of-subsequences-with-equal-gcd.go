func countSubsequences(nums []int, target int) int {
    mod := int(1e9) + 7
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    dp := make([]int, maxNum+1)
    for _, num := range nums {
        dp[num] += 1
    }

    for i := maxNum; i >= 1; i-- {
        cnt := 0
        for j := 2 * i; j <= maxNum; j += i {
            cnt += dp[j]
            cnt %= mod
        }
        dp[i] = (powMod(2, dp[i], mod) - 1 + mod) % mod
        for j := 2 * i; j <= maxNum; j += i {
            dp[i] = (dp[i] - dp[j] + mod) % mod
        }
    }

    res := 0
    for i := 1; i <= maxNum; i++ {
        if i == target {
            res = (res + dp[i]) % mod
        }
    }
    return res
}

func powMod(a, b, mod int) int {
    res := 1
    for b > 0 {
        if b&1 == 1 {
            res = (res * a) % mod
        }
        a = (a * a) % mod
        b >>= 1
    }
    return res
}