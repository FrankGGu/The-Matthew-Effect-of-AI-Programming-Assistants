func findIntegers(n int) int {
    f := make([]int, 32)
    f[0] = 1
    f[1] = 2
    for i := 2; i < 32; i++ {
        f[i] = f[i-1] + f[i-2]
    }

    res, prevBit := 0, 0
    for i := 30; i >= 0; i-- {
        if (n & (1 << i)) != 0 {
            res += f[i]
            if prevBit == 1 {
                res--
                break
            }
            prevBit = 1
        } else {
            prevBit = 0
        }
    }
    return res + 1
}