func separateBlackAndWhiteBalls(s string) int64 {
    var swaps int64 = 0
    leftmostZeroPos := 0 // This pointer indicates the next available position for a '0'

    for i := 0; i < len(s); i++ {
        if s[i] == '