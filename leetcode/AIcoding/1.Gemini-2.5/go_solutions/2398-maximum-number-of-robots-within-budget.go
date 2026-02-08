import "container/list"

func maximumRobots(chargeTimes []int, runningCosts []int, budget int) int {
	n := len(chargeTimes)
	if n == 0 {
		return 0
	}

	left := 0
	currentSumRunningCosts := 0
	maxK