func numberOfPoints(nums [][]int) int {
    points := make([]bool, 101)
    for _, interval := range nums {
        for i := interval[0]; i <= interval[1]; i++ {
            points[i] = true
        }
    }
    count := 0
    for i := 1; i <= 100; i++ {
        if points[i] {
            count++
        }
    }
    return count
}