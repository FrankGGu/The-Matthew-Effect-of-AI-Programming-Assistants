func carPooling(trips [][]int, capacity int) bool {
    time := make([]int, 1001)

    for _, trip := range trips {
        passengers, start, end := trip[0], trip[1], trip[2]
        time[start] += passengers
        time[end] -= passengers
    }

    currentPassengers := 0
    for _, change := range time {
        currentPassengers += change
        if currentPassengers > capacity {
            return false
        }
    }

    return true
}