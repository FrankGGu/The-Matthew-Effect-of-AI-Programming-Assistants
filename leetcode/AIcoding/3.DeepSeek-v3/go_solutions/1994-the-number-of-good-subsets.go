func numberOfGoodSubsets(nums []int) int {
    primes := []int{2, 3, 5, 7, 11, 13, 17, 19, 23, 29}
    mod := int(1e9 + 7)
    freq := make([]int, 31)
    for _, num := range nums {
        freq[num]++
    }

    mask := 1 << len(primes)
    dp := make([]int, mask)
    dp[0] = 1

    for num := 2; num <= 30; num++ {
        if freq[num] == 0 {
            continue
        }
        original := num
        currentMask := 0
        valid := true
        for i, p := range primes {
            cnt := 0
            for original%p == 0 {
                original /= p
                cnt++
            }
            if cnt > 1 {
                valid = false
                break
            }
            if cnt == 1 {
                currentMask |= 1 << i
            }
        }
        if !valid {
            continue
        }
        for m := mask - 1; m >= 0; m-- {
            if (m & currentMask) == 0 {
                dp[m | currentMask] = (dp[m | currentMask] + dp[m] * freq[num]) % mod
            }
        }
    }

    res := 0
    for m := 1; m < mask; m++ {
        res = (res + dp[m]) % mod
    }

    ones := 1
    for i := 0; i < freq[1]; i++ {
        ones = (ones * 2) % mod
    }
    res = (res * ones) % mod

    return res
}