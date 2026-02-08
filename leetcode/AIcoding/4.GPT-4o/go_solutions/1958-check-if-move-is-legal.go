func chessMove(x1, y1, x2, y2 int) bool {
    dx := abs(x2 - x1)
    dy := abs(y2 - y1)
    return (dx == 2 && dy == 1) || (dx == 1 && dy == 2)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}