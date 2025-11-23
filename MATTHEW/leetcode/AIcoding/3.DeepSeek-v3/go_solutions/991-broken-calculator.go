func brokenCalc(startValue int, target int) int {
    steps := 0
    for target > startValue {
        if target % 2 == 1 {
            target++
        } else {
            target /= 2
        }
        steps++
    }
    return steps + startValue - target
}