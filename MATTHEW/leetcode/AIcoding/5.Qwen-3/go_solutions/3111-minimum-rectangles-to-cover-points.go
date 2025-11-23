package main

func minRectanglesToCoverPoints(points [][]int, w int) int {
    sort.Slice(points, func(i, j int) bool {
        return points[i][0] < points[j][0]
    })
    res := 0
    for i := 0; i < len(points); {
        x := points[i][0]
        res++
        for i < len(points) && points[i][0] <= x+w {
            i++
        }
    }
    return res
}