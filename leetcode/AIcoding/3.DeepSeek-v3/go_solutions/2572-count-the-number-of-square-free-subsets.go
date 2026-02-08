func squareFreeSubsets(nums []int) int {
    primes := []int{2, 3, 5, 7, 11, 13, 17, 19, 23, 29}
    mod := int(1e9 + 7)
    n := len(primes)
    dp := make([]int, 1<<n)
    dp[0] = 1

    for _, num := range nums {
        mask := 0
        valid := true
        tmp := num
        for i, p := range primes {
            cnt := 0
            for tmp%p == 0 {
                tmp /= p
                cnt++
            }
            if cnt > 1 {
                valid = false
                break
            }
            if cnt == 1 {
                mask |= 1 << i
            }
        }
        if !valid {
            continue
        }
        for m := (1 << n) - 1; m >= 0; m-- {
            if m&mask == 0 {
                dp[m|mask] = (dp[m|mask] + dp[m]) % mod
            }
        }
    }

    res := 0
    for i := 1; i < (1 << n); i++ {
        res = (res + dp[i]) % mod
    }
    return res
}