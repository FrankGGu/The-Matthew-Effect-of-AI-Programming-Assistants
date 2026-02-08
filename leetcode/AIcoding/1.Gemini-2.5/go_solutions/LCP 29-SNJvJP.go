func orchestraLayout(num int, x int, y int) int {
    // k is the 0-indexed layer number for the given (x, y) coordinate.
    // It's the minimum distance from any border.
    k := min(x, y, num-1-x, num-1-y)

    //