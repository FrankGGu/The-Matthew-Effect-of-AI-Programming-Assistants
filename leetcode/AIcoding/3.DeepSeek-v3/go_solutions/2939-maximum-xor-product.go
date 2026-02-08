func maximumXorProduct(a int64, b int64, n int) int {
    const mod = 1e9 + 7
    x := int64(0)
    for i := n - 1; i >= 0; i-- {
        mask := int64(1) << i
        aBit := (a & mask) != 0
        bBit := (b & mask) != 0
        if aBit == bBit {
            x |= mask
        } else {
            if (a ^ x) < (b ^ x) {
                x |= mask
            }
        }
    }
    return int(((a ^ x) % mod) * ((b ^ x) % mod) % mod)
}