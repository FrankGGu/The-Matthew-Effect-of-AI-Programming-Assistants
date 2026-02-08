func carPooling(trips [][]int, capacity int) bool {
    maxLocation := 0
    for _, trip := range trips {
        if trip[2] > maxLocation {
            maxLocation = trip[2]
        }
    }

    diff := make([]int, maxLocation + 1)
    for _, trip := range trips {
        passengers, from, to := trip[0], trip[1], trip[2]
        diff[from] += passengers
        if to < len(diff) {
            diff[to] -= passengers
        }
    }

    currentPassengers := 0
    for i := 0; i < len(diff); i++ {
        currentPassengers += diff[i]
        if currentPassengers > capacity {
            return false
        }
    }
    return true
}