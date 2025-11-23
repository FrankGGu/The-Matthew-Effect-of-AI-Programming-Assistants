func getGoodIndices(variables [][]int) []int {

    pow := func(base, exp, mod int) int {
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

    var goodIndices []int
    for i, v := range variables {
        a, b, c, m := v[0], v[1], v[2], v[3]

        val1 := pow(a, b, 10)

        finalVal := pow(val1, c, m)

        if finalVal == 0 {
            goodIndices = append(goodIndices, i)
        }
    }

    return goodIndices
}