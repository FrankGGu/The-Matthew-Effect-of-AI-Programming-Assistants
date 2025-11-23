func carPooling(trips [][]int, capacity int) bool {
    stops := make([]int, 1001)
    for _, trip := range trips {
        numPassengers := trip[0]
        start := trip[1]
        end := trip[2]
        stops[start] += numPassengers
        stops[end] -= numPassengers
    }
    currentPassengers := 0
    for _, change := range stops {
        currentPassengers += change
        if currentPassengers > capacity {
            return false
        }
    }
    return true
}