func numPoints(points [][]int, r int) int {
    max := 0
    n := len(points)
    if n == 1 {
        return 1
    }
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            x1, y1 := points[i][0], points[i][1]
            x2, y2 := points[j][0], points[j][1]
            dx, dy := x2 - x1, y2 - y1
            d := math.Sqrt(float64(dx*dx + dy*dy))
            if d > 2 * float64(r) {
                continue
            }
            x0, y0 := float64(x1 + x2) / 2, float64(y1 + y2) / 2
            if d == 2 * float64(r) {
                cnt := 0
                for _, p := range points {
                    px, py := float64(p[0]), float64(p[1])
                    if (px - x0)*(px - x0) + (py - y0)*(py - y0) <= float64(r*r) + 1e-8 {
                        cnt++
                    }
                }
                if cnt > max {
                    max = cnt
                }
                continue
            }
            h := math.Sqrt(float64(r*r) - (d/2)*(d/2))
            nx, ny := -float64(dy), float64(dx)
            len := math.Sqrt(nx*nx + ny*ny)
            nx, ny = nx/len*h, ny/len*h
            for _, sign := range []float64{1, -1} {
                cx, cy := x0 + sign*nx, y0 + sign*ny
                cnt := 0
                for _, p := range points {
                    px, py := float64(p[0]), float64(p[1])
                    if (px - cx)*(px - cx) + (py - cy)*(py - cy) <= float64(r*r) + 1e-8 {
                        cnt++
                    }
                }
                if cnt > max {
                    max = cnt
                }
            }
        }
    }
    return max
}