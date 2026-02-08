func longestString(x int, y int, z int) int {
    minXY := x
    if y < minXY {
        minXY = y
    }
    if x == y {
        return (x + y + z) * 2
    }
    return (minXY*2 + 1 + z) * 2
}