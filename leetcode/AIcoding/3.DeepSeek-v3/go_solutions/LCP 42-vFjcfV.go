func numPoints(points [][]int, r int) int {
    max := 0
    n := len(points)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            x1, y1 := float64(points[i][0]), float64(points[i][1])
            x2, y2 := float64(points[j][0]), float64(points[j][1])
            dx, dy := x2 - x1, y2 - y1
            d := math.Sqrt(dx*dx + dy*dy)
            if d > 2 * float64(r) {
                continue
            }
            x0, y0 := (x1 + x2)/2, (y1 + y2)/2
            h := math.Sqrt(float64(r*r) - (d/2)*(d/2))
            cx1 := x0 - h * dy / d
            cy1 := y0 + h * dx / d
            cx2 := x0 + h * dy / d
            cy2 := y0 - h * dx / d
            cnt1, cnt2 := 0, 0
            for _, p := range points {
                px, py := float64(p[0]), float64(p[1])
                if (px - cx1)*(px - cx1) + (py - cy1)*(py - cy1) <= float64(r*r) + 1e-8 {
                    cnt1++
                }
                if (px - cx2)*(px - cx2) + (py - cy2)*(py - cy2) <= float64(r*r) + 1e-8 {
                    cnt2++
                }
            }
            if cnt1 > max {
                max = cnt1
            }
            if cnt2 > max {
                max = cnt2
            }
        }
    }
    if max == 0 {
        return 1
    }
    return max
}