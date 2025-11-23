import (
	"sort"
)

func defendSpaceCity(time []int, position []int, health []int) int64 {
	n := len(time)
	type event struct {
		t, i, op int
	}
	events := make([]event, 0, 2*n)
	for i := 0; i < n; i++ {
		events = append(events, event{time[i] - health[i] + 1, i, 0})
		events = append(events, event{time[i], i, 1})
	}
	sort.Slice(events, func(i, j int) bool {
		if events[i].t != events[j].t {
			return events[i].t < events[j].t
		}
		return events[i].op < events[j].op
	})

	ans := int64(0)
	pq := make([]int, 0)
	j := 0
	for i := 1; i <= time[n-1]; i++ {
		for j < len(events) && events[j].t == i {
			if events[j].op == 0 {
				pq = append(pq, position[events[j].i])
				sort.Ints(pq)
			} else {
				idx := sort.SearchInts(pq, position[events[j].i])
				pq = append(pq[:idx], pq[idx+1:]...)
			}
			j++
		}
		if len(pq) > 0 {
			ans += int64(pq[0])
			pq = pq[1:]
		}
	}
	return ans
}