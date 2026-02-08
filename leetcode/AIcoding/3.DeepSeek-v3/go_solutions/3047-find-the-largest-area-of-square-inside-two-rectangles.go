func largestSquareArea(leftBottom [][]int, rightTop [][]int) int64 {
    maxArea := 0
    n := len(leftBottom)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            x1 := max(leftBottom[i][0], leftBottom[j][0])
            y1 := max(leftBottom[i][1], leftBottom[j][1])
            x2 := min(rightTop[i][0], rightTop[j][0])
            y2 := min(rightTop[i][1], rightTop[j][1])
            if x1 < x2 && y1 < y2 {
                side := min(x2 - x1, y2 - y1)
                area := side * side
                if area > maxArea {
                    maxArea = area
                }
            }
        }
    }
    return int64(maxArea)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}