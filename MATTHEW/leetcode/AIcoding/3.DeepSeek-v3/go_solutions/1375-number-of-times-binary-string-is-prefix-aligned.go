func numTimesAllBlue(flips []int) int {
    maxPos := 0
    res := 0
    for i := 0; i < len(flips); i++ {
        if flips[i] > maxPos {
            maxPos = flips[i]
        }
        if maxPos == i+1 {
            res++
        }
    }
    return res
}