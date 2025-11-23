func numWaterBottles(numBottles int, numExchange int) int {
	totalDrunkBottles := 0
	emptyBottles := 0

	for numBottles > 0 {
		totalDrunkBottles += numBottles
		emptyBottles += numBottles

		newBottles := emptyBottles / numExchange
		emptyBottles = emptyBottles % numExchange
		numBottles = newBottles
	}

	return totalDrunkBottles
}