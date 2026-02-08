func countLatticePoints(circles [][]int) int {
    points := make(map[[2]int]bool)
    for _, circle := range circles {
        x, y, r := circle[0], circle[1], circle[2]
        for i := x - r; i <= x + r; i++ {
            for j := y - r; j <= y + r; j++ {
                if (i - x) * (i - x) + (j - y) * (j - y) <= r * r {
                    points[[2]int{i, j}] = true
                }
            }
        }
    }
    return len(points)
}