import (
    "sort"
)

func minRectanglesToCoverPoints(points [][]int, w int) int {
    if len(points) == 0 {
        return 0
    }
    sort.Slice(points, func(i, j int) bool {
        return points[i][0] < points[j][0]
    })
    res := 0
    last := -1
    for _, p := range points {
        if p[0] > last {
            res++
            last = p[0] + w
        }
    }
    return res
}