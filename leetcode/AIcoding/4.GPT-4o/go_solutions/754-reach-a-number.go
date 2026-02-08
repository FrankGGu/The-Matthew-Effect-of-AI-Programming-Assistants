func reachNumber(target int) int {
    target = abs(target)
    step := 0
    sum := 0
    for sum < target || (sum-target)%2 != 0 {
        step++
        sum += step
    }
    return step
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}