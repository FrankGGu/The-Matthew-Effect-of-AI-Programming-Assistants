package main

func maxArea(boxes []int, points []int) int {
    n := len(boxes)
    m := len(points)
    area := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            x1, y1 := boxes[i], boxes[i+1]
            x2, y2 := boxes[j], boxes[j+1]
            if x1 > x2 {
                x1, x2 = x2, x1
            }
            if y1 > y2 {
                y1, y2 = y2, y1
            }
            for k := 0; k < m; k++ {
                px, py := points[k], points[k+1]
                if px >= x1 && px <= x2 && py >= y1 && py <= y2 {
                    area = max(area, (x2-x1)*(y2-y1))
                    break
                }
            }
        }
    }
    return area
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}