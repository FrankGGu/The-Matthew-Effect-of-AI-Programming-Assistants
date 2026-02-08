func garbageCollection(garbage []string, travel []int) int {
    totalTime := 0
    totalTravelTime := 0
    lastTrashIndex := 0

    for i, g := range garbage {
        totalTime += len(g)
        if len(g) > 0 {
            lastTrashIndex = i
        }
    }

    for i := 0; i < lastTrashIndex; i++ {
        totalTravelTime += travel[i]
    }

    return totalTime + totalTravelTime
}