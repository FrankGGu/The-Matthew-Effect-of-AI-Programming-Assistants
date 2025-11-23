func countGoodRectangles(rectangles [][]int) int {
    maxLen := 0
    count := 0

    for _, rect := range rectangles {
        side := min(rect[0], rect[1])
        if side > maxLen {
            maxLen = side
            count = 1
        } else if side == maxLen {
            count++
        }
    }

    return count
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}