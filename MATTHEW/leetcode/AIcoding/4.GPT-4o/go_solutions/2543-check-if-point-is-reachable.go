func isReachable(x int, y int) bool {
    return (x+y)%3 == 0 && x <= 2*y && y <= 2*x
}