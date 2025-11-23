func productQueries(n int, queries [][]int) []int {
    powers := []int{}
    for i := 0; i < 32; i++ {
        if n&(1<<i) != 0 {
            powers = append(powers, 1<<i)
        }
    }

    prefix := make([]int, len(powers)+1)
    prefix[0] = 1
    for i := 0; i < len(powers); i++ {
        prefix[i+1] = (prefix[i] * powers[i]) % (1e9 + 7)
    }

    res := make([]int, len(queries))
    for i, q := range queries {
        l, r := q[0], q[1]
        res[i] = (prefix[r+1] * powMod(prefix[l], 1e9+5, 1e9+7)) % (1e9 + 7)
    }
    return res
}

func powMod(a, b, mod int) int {
    res := 1
    a %= mod
    for b > 0 {
        if b&1 == 1 {
            res = (res * a) % mod
        }
        a = (a * a) % mod
        b >>= 1
    }
    return res
}