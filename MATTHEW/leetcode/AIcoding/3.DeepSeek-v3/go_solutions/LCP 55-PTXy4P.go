func getMinimumTime(time []int, fruits [][]int, limit int) int {
    totalTime := 0
    for _, fruit := range fruits {
        type_, num := fruit[0], fruit[1]
        batches := (num + limit - 1) / limit
        totalTime += batches * time[type_]
    }
    return totalTime
}