func isReachable(targetX int, targetY int) bool {
    for targetX%2 == 0 {
        targetX /= 2
    }
    for targetY%2 == 0 {
        targetY /= 2
    }
    gcd := func(a, b int) int {
        for b != 0 {
            a, b = b, a%b
        }
        return a
    }
    return gcd(targetX, targetY) == 1
}