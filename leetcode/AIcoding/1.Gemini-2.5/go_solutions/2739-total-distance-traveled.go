func distanceTraveled(mainTank int, additionalTank int) int {
    totalDistance := 0

    for mainTank >= 5 {
        // Consume 5 liters from mainTank
        totalDistance += 50 // 5 liters * 10 km/liter
        mainTank -= 5

        // Transfer 1 liter from