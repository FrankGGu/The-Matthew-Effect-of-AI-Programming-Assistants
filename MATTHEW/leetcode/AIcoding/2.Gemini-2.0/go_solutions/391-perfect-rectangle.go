func isRectangleCover(rectangles [][]int) bool {
    if len(rectangles) == 0 {
        return true
    }

    area := 0
    left := rectangles[0][0]
    right := rectangles[0][2]
    top := rectangles[0][3]
    bottom := rectangles[0][1]

    corners := make(map[string]bool)

    for _, rect := range rectangles {
        left = min(left, rect[0])
        bottom = min(bottom, rect[1])
        right = max(right, rect[2])
        top = max(top, rect[3])

        area += (rect[2] - rect[0]) * (rect[3] - rect[1])

        a := rect[0]
        b := rect[1]
        c := rect[2]
        d := rect[3]

        corners[fmt.Sprintf("%d %d", a, b)] = !corners[fmt.Sprintf("%d %d", a, b)]
        corners[fmt.Sprintf("%d %d", a, d)] = !corners[fmt.Sprintf("%d %d", a, d)]
        corners[fmt.Sprintf("%d %d", c, b)] = !corners[fmt.Sprintf("%d %d", c, b)]
        corners[fmt.Sprintf("%d %d", c, d)] = !corners[fmt.Sprintf("%d %d", c, d)]
    }

    expectedArea := (right - left) * (top - bottom)
    if area != expectedArea {
        return false
    }

    count := 0
    for _, exists := range corners {
        if exists {
            count++
        }
    }

    if count != 4 {
        return false
    }

    if !corners[fmt.Sprintf("%d %d", left, bottom)] {
        return false
    }
    if !corners[fmt.Sprintf("%d %d", left, top)] {
        return false
    }
    if !corners[fmt.Sprintf("%d %d", right, bottom)] {
        return false
    }
    if !corners[fmt.Sprintf("%d %d", right, top)] {
        return false
    }

    return true
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
import "fmt"