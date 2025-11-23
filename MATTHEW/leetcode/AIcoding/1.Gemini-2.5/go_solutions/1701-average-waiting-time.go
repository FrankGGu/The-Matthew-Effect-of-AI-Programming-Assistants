func averageWaitingTime(customers [][]int) float64 {
	totalWaitingTime := int64(0)
	currentTime := int64(0)

	for _, customer := range customers {
		arrivalTime := int64(customer[0])
		prepTime := int64(customer[1])

		startTime := currentTime
		if arrivalTime > startTime {
			startTime = arrivalTime
		}

		finishTime := startTime + prepTime
		waitingTime := finishTime - arrivalTime
		totalWaitingTime += waitingTime

		currentTime = finishTime
	}

	return float64(totalWaitingTime) / float64(len(customers))
}