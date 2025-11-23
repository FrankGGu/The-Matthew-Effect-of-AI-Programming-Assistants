package main

func largestTriangleArea(problems [][]int) float64 {
    maxArea := 0.0
    for i := 0; i < len(problems); i++ {
        for j := i + 1; j < len(problems); j++ {
            for k := j + 1; k < len(problems); k++ {
                x1, y1 := problems[i][0], problems[i][1]
                x2, y2 := problems[j][0], problems[j][1]
                x3, y3 := problems[k][0], problems[k][1]
                area := 0.5 * float64(abs((x2-x1)*(y3-y1)-(x3-x1)*(y2-y1)))
                if area > maxArea {
                    maxArea = area
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