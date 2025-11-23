import (
	"sort"
)

type event struct {
	time int
	typ  int
}

func minChairs(times [][]int) int {
	events := make([]event, 0, len(times)*2)
	for _, t := range times {
		events = append(events, event{t[0], 1})
		events = append(events, event{t[1], -1})
	}

	sort.Slice(events, func(i, j int) bool {
		if events[i].time != events[j].time {
			return events[i].time < events[j].time
		}
		return events[i].typ > events[j].typ
	})

	currentChairs := 0
	maxChairs := 0

	for _, e := range events {
		currentChairs += e.typ
		if currentChairs > maxChairs {
			maxChairs = currentChairs
		}
	}

	return maxChairs
}