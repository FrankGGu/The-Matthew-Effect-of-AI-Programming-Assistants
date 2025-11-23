func maxProfit(customers []int, boardingCost int, runningCost int) int {
	maxProfitVal := -1
	maxRotations := -1

	currentOnWheel := 0
	totalRotations := 0
	totalBoardedCustomers := 0

	for _, c := range customers {
		totalRotations++
		currentOnWheel += c

		boardedThisRotation := 0
		if currentOnWheel >= 4 {
			boardedThisRotation = 4
		} else {
			boardedThisRotation = currentOnWheel
		}

		currentOnWheel -= boardedThisRotation
		totalBoardedCustomers += boardedThisRotation

		profit := totalBoardedCustomers*boardingCost - totalRotations*runningCost

		if profit > maxProfitVal {
			maxProfitVal = profit
			maxRotations = totalRotations
		}
	}

	for currentOnWheel > 0 {
		totalRotations++

		boardedThisRotation := 0
		if currentOnWheel >= 4 {
			boardedThisRotation = 4
		} else {
			boardedThisRotation = currentOnWheel
		}

		currentOnWheel -= boardedThisRotation
		totalBoardedCustomers += boardedThisRotation

		profit := totalBoardedCustomers*boardingCost - totalRotations*runningCost

		if profit > maxProfitVal {
			maxProfitVal = profit
			maxRotations = totalRotations
		}
	}

	return maxRotations
}