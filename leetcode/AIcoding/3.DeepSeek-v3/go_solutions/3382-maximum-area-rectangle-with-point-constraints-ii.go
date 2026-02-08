func maxAreaRectWithPoint(points [][]int, point []int) int {
    pointSet := make(map[[2]int]bool)
    for _, p := range points {
        pointSet[[2]int{p[0], p[1]}] = true
    }

    maxArea := 0
    n := len(points)
    for i := 0; i < n; i++ {
        x1, y1 := points[i][0], points[i][1]
        for j := i + 1; j < n; j++ {
            x2, y2 := points[j][0], points[j][1]
            if x1 != x2 && y1 != y2 {
                if pointSet[[2]int{x1, y2}] && pointSet[[2]int{x2, y1}] {
                    area := abs(x2 - x1) * abs(y2 - y1)
                    if area > maxArea {
                        if point[0] == -1 && point[1] == -1 {
                            maxArea = area
                        } else {
                            if (x1 == point[0] && y1 == point[1]) || 
                               (x2 == point[0] && y2 == point[1]) || 
                               (x1 == point[0] && y2 == point[1]) || 
                               (x2 == point[0] && y1 == point[1]) {
                                maxArea = area
                            }
                        }
                    }
                }
            }
        }
    }
    return maxArea
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}