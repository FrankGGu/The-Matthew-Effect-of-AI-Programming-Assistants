func maxPointsInsideSquare(points [][]int, s string) int {
    minDist := make(map[int]int)
    for i, p := range points {
        x, y := p[0], p[1]
        dist := max(abs(x), abs(y))
        if _, exists := minDist[dist]; exists {
            if s[i] < s[minDist[dist]] {
                minDist[dist] = i
            }
        } else {
            minDist[dist] = i
        }
    }

    sortedDists := make([]int, 0, len(minDist))
    for d := range minDist {
        sortedDists = append(sortedDists, d)
    }
    sort.Ints(sortedDists)

    tags := make(map[byte]bool)
    res := 0
    for _, d := range sortedDists {
        idx := minDist[d]
        tag := s[idx]
        if tags[tag] {
            return res
        }
        tags[tag] = true
        res++
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}