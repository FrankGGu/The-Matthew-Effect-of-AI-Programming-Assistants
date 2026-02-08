func isReachable(targetX int, targetY int) bool {
    return gcd(targetX, targetY) == 1
}

func gcd(a, b int) int {
    for b != 0 {
        a, b =