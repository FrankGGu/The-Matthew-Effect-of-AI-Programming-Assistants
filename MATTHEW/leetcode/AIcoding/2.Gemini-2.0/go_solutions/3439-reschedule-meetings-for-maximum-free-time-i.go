import (
	"sort"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func maxFreeTime(meetings [][]int) int {
	events := []int{}
	for _, meeting := range meetings {
		events = append(events, meeting[0], -meeting[1])
	}

	sort.Ints(events)

	freeTime := 0
	curBusy := 0
	prevTime := 0
	for i := 0; i < len(events); i++ {
		time := events[i]
		if time > 0 {
			if curBusy == 0 && prevTime != 0 {
				freeTime = max(freeTime, time-prevTime)
			}
			curBusy++
			prevTime = time
		} else {
			curBusy--
			prevTime = -time
		}
	}

	return freeTime
}