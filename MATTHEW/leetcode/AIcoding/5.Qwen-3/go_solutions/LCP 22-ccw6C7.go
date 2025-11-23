package main

func drawLine(width int, height int, x1 int, x2 int, y int) []int {
    result := make([]int, height)
    for i := range result {
        result[i] = 0
    }
    if y < 0 || y >= height {
        return result
    }
    for x := x1; x <= x2; x++ {
        if x >= 0 && x < width {
            result[y] |= 1 << (width - 1 - x)
        }
    }
    return result
}