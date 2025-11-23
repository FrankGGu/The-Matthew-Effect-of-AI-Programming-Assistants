package main

func maxDistance(points [][]int, k int) int {
    sort.Slice(points, func(i, j int) bool {
        return points[i][0]+points[i][1] < points[j][0]+points[j][1]
    })
    n := len(points)
    for i := 0; i < n; i++ {
        points[i][0], points[i][1] = points[i][1], points[i][0]
    }
    sort.Slice(points, func(i, j int) bool {
        return points[i][0]-points[i][1] < points[j][0]-points[j][1]
    })
    res := 0
    for i := 0; i < n; i++ {
        if i < k {
            points[i][0], points[i][1] = -points[i][0], -points[i][1]
        }
        res = max(res, points[i][0]+points[i][1])
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}