func doubleModPow(a []int, b []int, c []int, d []int) []int {
    n := len(a)
    res := make([]int, n)
    for i := 0; i < n; i++ {
        first := powMod(a[i], b[i], 10)
        second := powMod(first, c[i], d[i])
        res[i] = second
    }
    return res
}

func powMod(x, y, mod int) int {
    res := 1
    x = x % mod
    for y > 0 {
        if y%2 == 1 {
            res = (res * x) % mod
        }
        y = y >> 1
        x = (x * x) % mod
    }
    return res
}