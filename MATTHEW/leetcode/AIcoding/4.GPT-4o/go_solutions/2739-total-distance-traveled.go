func distanceTraveled(mainTank int, additionalTank int) int {
    totalDistance := 0
    if mainTank > 0 {
        if mainTank <= 5 {
            totalDistance += mainTank * 10
        } else {
            totalDistance += 50 + (mainTank-5)*10
            if additionalTank > 0 {
                if additionalTank+mainTank > 5 {
                    totalDistance += 50
                } else {
                    totalDistance += additionalTank * 10
                }
            }
        }
    }
    return totalDistance
}