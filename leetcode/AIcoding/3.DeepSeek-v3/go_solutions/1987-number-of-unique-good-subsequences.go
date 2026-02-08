func numberOfUniqueGoodSubsequences(binary string) int {
    mod := int(1e9 + 7)
    dp0, dp1 := 0, 0
    has0 := 0
    for i := len(binary) - 1; i >= 0; i-- {
        if binary[i] == '0' {
            has0 = 1
            dp0 = (dp0 + dp1 + 1) % mod
        } else {
            dp1 = (dp0 + dp1 + 1) % mod
        }
    }
    return (dp1 + has0) % mod
}