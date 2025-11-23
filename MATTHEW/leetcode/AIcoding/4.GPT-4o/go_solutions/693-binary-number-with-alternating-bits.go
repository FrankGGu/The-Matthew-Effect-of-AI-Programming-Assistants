func hasAlternatingBits(n int) bool {
    prevBit := n & 1
    n >>= 1
    for n > 0 {
        currBit := n & 1
        if currBit == prevBit {
            return false
        }
        prevBit = currBit
        n >>= 1
    }
    return true
}