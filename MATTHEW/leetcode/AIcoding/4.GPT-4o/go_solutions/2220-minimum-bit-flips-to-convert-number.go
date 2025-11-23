func minBitFlips(start int, goal int) int {
    return countBits(start ^ goal)
}

func countBits(n int) int {
    count := 0
    for n > 0 {
        count += n & 1
        n >>= 1
    }
    return count
}