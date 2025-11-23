func monkeyMove(n int) int {
    mod := int(1e9 + 7)
    pow := func(x, y int) int {
        res := 1
        for y > 0 {
            if y&1 == 1 {
                res = (res * x) % mod
            }
            x = (x * x) % mod
            y >>= 1
        }
        return res
    }
    return (pow(2, n) - 2 + mod) % mod
}