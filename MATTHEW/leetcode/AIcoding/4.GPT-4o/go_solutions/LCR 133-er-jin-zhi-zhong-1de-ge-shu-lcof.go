func hammingWeight(n uint32) int {
    count := 0
    for n > 0 {
        count++
        n &= n - 1
    }
    return count
}