package main

func minimumArea(rectangles [][]int) int {
    minRow, minCol, maxRow, maxCol := 100, 100, 0, 0
    for _, rect := range rectangles {
        row, col, width, height := rect[0], rect[1], rect[2], rect[3]
        minRow = min(minRow, row)
        minCol = min(minCol, col)
        maxRow = max(maxRow, row+width-1)
        maxCol = max(maxCol, col+height-1)
    }
    return (maxRow - minRow + 1) * (maxCol - minCol + 1)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}