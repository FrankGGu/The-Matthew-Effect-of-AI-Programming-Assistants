func reachNumber(target int) int {
    if target < 0 {
        target = -target
    }
    k := 0
    sum := 0
    for sum < target || (sum-target)%2 != 0 {
        k++
        sum += k
    }
    return k
}