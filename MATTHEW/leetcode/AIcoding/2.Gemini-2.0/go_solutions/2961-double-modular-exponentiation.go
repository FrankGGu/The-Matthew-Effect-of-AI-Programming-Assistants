func doubleModular(nums [][]int) []int {
    res := make([]int, len(nums))
    for i, num := range nums {
        a, b, c, m := num[0], num[1], num[2], num[3]
        res[i] = power(power(a, b, 100), c, m)
    }
    return res
}

func power(base, exp, mod int) int {
    res := 1
    base %= mod
    for exp > 0 {
        if exp%2 == 1 {
            res = (res * base) % mod
        }
        base = (base * base) % mod
        exp /= 2
    }
    return res
}