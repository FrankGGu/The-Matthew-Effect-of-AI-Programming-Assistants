func getMinDistSum(positions [][]int) float64 {
    n := len(positions)
    if n == 1 {
        return 0.0
    }

    x, y := 0.0, 0.0
    for _, pos := range positions {
        x += float64(pos[0])
        y += float64(pos[1])
    }
    x /= float64(n)
    y /= float64(n)

    step := 100.0
    minDist := calcDist(x, y, positions)

    for step > 1e-6 {
        improved := false
        for _, dir := range [][]float64{{0, 1}, {1, 0}, {0, -1}, {-1, 0}} {
            nx := x + step * dir[0]
            ny := y + step * dir[1]
            dist := calcDist(nx, ny, positions)
            if dist < minDist {
                minDist = dist
                x, y = nx, ny
                improved = true
                break
            }
        }
        if !improved {
            step /= 2.0
        }
    }

    return minDist
}

func calcDist(x, y float64, positions [][]int) float64 {
    dist := 0.0
    for _, pos := range positions {
        dx := x - float64(pos[0])
        dy := y - float64(pos[1])
        dist += math.Sqrt(dx*dx + dy*dy)
    }
    return dist
}