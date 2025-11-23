func maxPoints(points [][]int) int {
    n := len(points)
    if n <= 2 {
        return n
    }
    max := 0
    for i := 0; i < n; i++ {
        slopeMap := make(map[string]int)
        same := 1
        for j := i + 1; j < n; j++ {
            dx := points[i][0] - points[j][0]
            dy := points[i][1] - points[j][1]
            if dx == 0 && dy == 0 {
                same++
                continue
            }
            g := gcd(dx, dy)
            key := fmt.Sprintf("%d/%d", dx/g, dy/g)
            slopeMap[key]++
        }
        currentMax := 0
        for _, v := range slopeMap {
            if v > currentMax {
                currentMax = v
            }
        }
        currentMax += same
        if currentMax > max {
            max = currentMax
        }
    }
    return max
}

func gcd(a, b int) int {
    if b == 0 {
        return a
    }
    return gcd(b, a % b)
}