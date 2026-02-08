func countGoodNumbers(n int64) int64 {
    const mod = 1_000_000_007
    if n == 1 {
        return 5
    }
    var pow func(x, y int64) int64
    pow = func(x, y int64) int64 {
        res := int64(1)
        x = x % mod
        for y > 0 {
            if y%2 == 1 {
                res = (res * x) % mod
            }
            y /= 2
            x = (x * x) % mod
        }
        return res
    }
    even := n / 2
    odd := (n + 1) / 2
    return (pow(5, odd) * pow(4, even)) % mod
}