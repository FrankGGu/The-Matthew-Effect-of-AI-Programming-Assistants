func numTimesAllBlue(flips []int) int {
    maxOnBulb := 0
    count := 0
    for i := 0; i < len(flips); i++ {
        if flips[i] > maxOnBulb {
            maxOnBulb = flips[i]
        }