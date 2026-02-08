import "sort"

func maxRectangle(points [][]int) int {
    n := len(points)
    if n < 4 {
        return 0
    }

    pointSet := make(map[[2]int]bool)
    for _, p := range points {
        pointSet[[2]int{p[0], p[1]}] = true
    }

    maxArea := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if points[i][0] == points[j][0] || points[i][1] == points[j][1] {
                continue
            }
            p1 := [2]int{points[i][0], points[j][1]}
            p2 := [2]int{points[j][0], points[i][1]}
            if pointSet[p1] && pointSet[p2] {
                area := abs(points[i][0]-points[j][0]) * abs(points[i][1]-points[j][1])
                maxArea = max(maxArea, area)
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

func max(x, y int) int {
    if x > y {
        return x
    }
    return y
}