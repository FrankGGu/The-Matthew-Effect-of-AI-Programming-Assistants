func minimumTravelTime(operations [][]int) int {
    n := len(operations)
    total := 0
    for i := 0; i < n; i++ {
        total += operations[i][0] * operations[i][1]
    }

    minTime := 0
    for i := 0; i < n; i++ {
        minTime += operations[i][0]
    }

    return total - minTime
}