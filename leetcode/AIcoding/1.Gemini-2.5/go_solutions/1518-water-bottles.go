func numWaterBottles(numBottles int, numExchange int) int {
	drunkBottles := numBottles
	emptyBottles := numBottles

	for emptyBottles >= numExchange {
		newFullBottles := emptyBottles / numExchange
		drunkBottles += newFullBottles
		emptyBottles = (emptyBottles % numExchange) + newFullBottles
	}

	return drunkBottles
}