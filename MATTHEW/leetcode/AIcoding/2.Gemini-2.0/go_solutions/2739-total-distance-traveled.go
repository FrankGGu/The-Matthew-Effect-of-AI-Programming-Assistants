func distanceTraveled(mainTank int, additionalTank int) int {
	distance := 0
	for mainTank > 0 {
		if mainTank >= 5 {
			if additionalTank > 0 {
				distance += 50
				mainTank -= 5
				additionalTank -= 1
			} else {
				distance += mainTank * 10
				mainTank = 0
			}
		} else {
			distance += mainTank * 10
			mainTank = 0
		}
	}
	return distance
}