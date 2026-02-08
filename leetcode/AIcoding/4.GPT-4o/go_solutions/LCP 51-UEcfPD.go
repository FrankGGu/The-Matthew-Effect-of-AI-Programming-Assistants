func cook(dishes [][]int) int {
    n := len(dishes)
    totalTime := 0
    for i := 0; i < n; i++ {
        totalTime += dishes[i][0] + dishes[i][1]
    }
    return totalTime
}