func maxArea(rect1 []int, rect2 []int) int {
    x1, y1, x2, y2 := rect1[0], rect1[1], rect1[2], rect1[3]
    x3, y3, x4, y4 := rect2[0], rect2[1], rect2[2], rect2[3]

    left := max(x1, x3)
    right := min(x2, x4)
    bottom := max(y1, y3)
    top := min(y2, y4)

    if left >= right || bottom >= top {
        return 0
    }

    side := min(right-left, top-bottom)
    return side * side
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