func countLatticePoints(circles [][]int) int {
    count := 0
    seen := make(map[int]bool)
    for _, circle := range circles {
        x, y, r := circle[0], circle[1], circle[2]
        for i := x - r; i <= x + r; i++ {
            for j := y - r; j <= y + r; j++ {
                if (i - x) * (i - x) + (j - y) * (j - y) <= r * r {
                    hash := i*201 + j
                    if !seen[hash] {
                        count++
                        seen[hash] = true
                    }
                }
            }
        }
    }
    return count
}