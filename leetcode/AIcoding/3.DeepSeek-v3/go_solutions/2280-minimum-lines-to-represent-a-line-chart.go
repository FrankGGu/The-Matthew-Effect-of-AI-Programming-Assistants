func minimumLines(points [][]int) int {
    n := len(points)
    if n <= 2 {
        return n - 1
    }
    sort.Slice(points, func(i, j int) bool {
        if points[i][0] == points[j][0] {
            return points[i][1] < points[j][1]
        }
        return points[i][0] < points[j][0]
    })

    res := 1
    for i := 2; i < n; i++ {
        x1, y1 := points[i-2][0], points[i-2][1]
        x2, y2 := points[i-1][0], points[i-1][1]
        x3, y3 := points[i][0], points[i][1]
        area := (x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1)
        if area != 0 {
            res++
        }
    }
    return res
}