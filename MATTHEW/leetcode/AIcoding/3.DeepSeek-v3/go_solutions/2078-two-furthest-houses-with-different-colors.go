func maxDistance(colors []int) int {
    n := len(colors)
    maxDist := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if colors[i] != colors[j] {
                dist := j - i
                if dist > maxDist {
                    maxDist = dist
                }
            }
        }
    }
    return maxDist
}