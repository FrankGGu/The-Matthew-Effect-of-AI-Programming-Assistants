func numberOfPairs(points [][]int) int {
    sort.Slice(points, func(i, j int) bool {
        if points[i][0] == points[j][0] {
            return points[i][1] > points[j][1]
        }
        return points[i][0] < points[j][0]
    })

    res := 0
    n := len(points)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            x1, y1 := points[i][0], points[i][1]
            x2, y2 := points[j][0], points[j][1]
            if y1 < y2 {
                continue
            }
            valid := true
            for k := 0; k < n; k++ {
                if k == i || k == j {
                    continue
                }
                x, y := points[k][0], points[k][1]
                if x >= x1 && x <= x2 && y <= y1 && y >= y2 {
                    valid = false
                    break
                }
            }
            if valid {
                res++
            }
        }
    }
    return res
}