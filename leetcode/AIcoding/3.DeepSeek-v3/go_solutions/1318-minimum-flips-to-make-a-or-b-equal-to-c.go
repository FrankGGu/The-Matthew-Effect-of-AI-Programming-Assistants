func minFlips(a int, b int, c int) int {
    flips := 0
    for i := 0; i < 32; i++ {
        aBit := (a >> i) & 1
        bBit := (b >> i) & 1
        cBit := (c >> i) & 1

        if (aBit | bBit) != cBit {
            if cBit == 1 {
                flips++
            } else {
                flips += aBit + bBit
            }
        }
    }
    return flips
}