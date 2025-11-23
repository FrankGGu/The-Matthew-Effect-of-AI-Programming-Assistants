func hammingDistance(x int, y int) int {
    return countBits(x ^ y)
}

func countBits(n int) int {
    count := 0
    for n > 0 {
        count += n & 1
        n >>= 1
    }
    return count
}