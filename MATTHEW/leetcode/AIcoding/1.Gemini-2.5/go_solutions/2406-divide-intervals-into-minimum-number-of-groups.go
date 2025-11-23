import (
	"sort"
)

type Event struct {
	time    int
	isStart bool // true for start, false for end
}

func minGroups(intervals [][]int) int {
	events := make([]Event, 0, len(intervals)*2)
	for _, interval := range intervals {
		events = append(events, Event{time: interval[0], isStart: true})
		events = append(events, Event{time: interval[1], isStart: false})
	}

	sort.Slice(events, func(i, j int) bool {
		if events[i].time != events[j].time {
			return events[i].time < events[j].time
		}
		// If times are equal, process end events before start events.
		// This ensures that an interval ending at time T and another starting at time T
		// are not considered overlapping at time T.
		// `!events[i].isStart` is true if events[i] is an end event.
		// `events[j].isStart` is true if events[j] is a start event.
		// So, `true && true` means events[i] is an end event and events[j] is a start event,
		// in which case events[i] should come before events[j].
		return !events[i].isStart && events[j].isStart
	})

	activeIntervals := 0
	maxGroups := 0

	for _, event := range events {
		if event.isStart {
			activeIntervals++
		} else {
			activeIntervals--
		}
		if activeIntervals > maxGroups {
			maxGroups = activeIntervals
		}
	}

	return maxGroups
}