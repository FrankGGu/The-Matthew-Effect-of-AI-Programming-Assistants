func carPooling(trips [][]int, capacity int) bool {
    // The maximum location is 1000. We need an array to store changes at each location.
    // Index 0 to 1000, so size 1001.
    var locationChanges [1001]int

    for _, trip := range trips {
        numPassengers := trip[0]
        from := trip[1]
        to := trip[2]

        // At 'from' location, passengers enter.
        locationChanges[from] += numPassengers
        // At 'to' location, passengers exit. Since 'to' is exclusive, they exit at 'to'.
        locationChanges[to] -= numPassengers
    }

    currentPassengers := 0
    // Iterate through all possible locations from 0 to 1000.
    for i := 0; i < 1001; i++ {
        currentPassengers += locationChanges[i]
        if currentPassengers > capacity {
            return false
        }
    }

    return true
}