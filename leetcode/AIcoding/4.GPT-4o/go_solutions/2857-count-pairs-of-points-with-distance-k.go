func countPairs(points [][]int, k int) int {
    count := 0
    n := len(points)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            dist := (points[i][0]-points[j][0])*(points[i][0]-points[j][0]) + (points[i][1]-points[j][1])*(points[i][1]-points[j][1])
            if dist == k*k {
                count++
            }
        }
    }
    return count
}