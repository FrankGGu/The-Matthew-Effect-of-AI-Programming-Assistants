func isCellReachable(row int, col int, time int) bool {
    return (row + col) <= time && (time - (row + col)) % 2 == 0
}