func minBitFlips(start int, goal int) int {
    xorResult := start ^ goal
    flips := 0
    for xorResult > 0 {
        flips++
        xorResult &= (xorResult - 1)
    }
    return flips
}