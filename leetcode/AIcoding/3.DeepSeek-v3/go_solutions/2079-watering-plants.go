func wateringPlants(plants []int, capacity int) int {
    steps := 0
    currentWater := capacity
    for i := 0; i < len(plants); i++ {
        if currentWater < plants[i] {
            steps += 2 * i
            currentWater = capacity
        }
        steps++
        currentWater -= plants[i]
    }
    return steps
}