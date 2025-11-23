func numberOfPoints(nums [][]int) int {
    points := make(map[int]bool)
    for _, interval := range nums {
        start, end := interval[0], interval[1]
        for i := start; i <= end; i++ {
            points[i] = true
        }
    }
    return len(points)
}