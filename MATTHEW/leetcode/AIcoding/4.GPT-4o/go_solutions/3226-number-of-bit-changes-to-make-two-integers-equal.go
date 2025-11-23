func countBitChanges(a int, b int) int {
    return bitCount(a ^ b)
}

func bitCount(x int) int {
    count := 0
    for x > 0 {
        count += x & 1
        x >>= 1
    }
    return count
}