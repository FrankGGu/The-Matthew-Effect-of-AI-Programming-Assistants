func brokenCalc(startValue int, target int) int {
    ans := 0
    for target > startValue {
        if target % 2 == 0 {
            target /= 2
        } else {
            target++
        }
        ans++
    }
    return ans + startValue - target
}