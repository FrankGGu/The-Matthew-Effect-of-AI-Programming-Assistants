func isReachable(targetX int, targetY int) bool {
    for targetX%2 == 0 {
        targetX /= 2
    }
    for targetY%2 == 0 {
        targetY /= 2
    }
    return gcd(targetX, targetY) == 1
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}