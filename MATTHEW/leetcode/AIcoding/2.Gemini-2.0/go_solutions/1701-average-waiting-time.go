import "fmt"

func averageWaitingTime(customers [][]int) float64 {
	currentTime := 0
	totalWaitingTime := 0
	for _, customer := range customers {
		arrival := customer[0]
		duration := customer[1]
		if currentTime <= arrival {
			currentTime = arrival + duration
			totalWaitingTime += duration
		} else {
			waitingTime := currentTime - arrival
			currentTime += duration
			totalWaitingTime += waitingTime + duration
		}
	}
	return float64(totalWaitingTime) / float64(len(customers))
}