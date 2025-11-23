func wateringPlants(plants []int, capacity int) int {
    totalSteps := 0
    currentWater := capacity

    for i := 0; i < len(plants); i++ {
        if currentWater < plants[i] {
            totalSteps += 2*i // Go back to the river
            currentWater = capacity // Refill the watering can
        }
        totalSteps++ // Water the plant
        currentWater -= plants[i]
    }

    return totalSteps
}