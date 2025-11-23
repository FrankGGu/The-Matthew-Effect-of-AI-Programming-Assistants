func wateringPlants(plants []int, capacity int) int {
    steps := 0
    currentWater := capacity

    for i := 0; i < len(plants); i++ {
        if currentWater < plants[i] {
            // Go back to the river
            steps += i // Steps from current plant i-1 (conceptually