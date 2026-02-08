func minEnd(n int, x int) int64 {
    res := int64(x)
    n--
    for i := 0; i < 64; i++ {
        if (x >> i) & 1 == 0 {
            if n & 1 == 1 {
                res |= 1 << i
            }
            n >>= 1
        }
    }
    return res
}