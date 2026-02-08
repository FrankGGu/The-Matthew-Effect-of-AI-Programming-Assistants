func isReachable(x1 int, y1 int, x2 int, y2 int) bool {
    return (x1 + y1) % 2 == (x2 + y2) % 2 && x1 <= x2 && y1 <= y2
}