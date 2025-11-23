import "sort"

func countCoveredBuildings(buildings [][]int) []int {
	n := len(buildings)
	events := make([][]int, 0)
	for i := 0; i < n; i++ {
		events = append(events, []int{buildings[i][0], buildings[i][2], 1})
		events = append(events, []int{buildings[i][1], buildings[i][2], -1})
	}
	sort.Slice(events, func(i, j int) bool {
		if events[i][0] == events[j][0] {
			return events[i][2] > events[j][2]
		}
		return events[i][0] < events[j][0]
	})

	heights := []int{}
	res := make([]int, 0)
	var prev int
	for i := 0; i < len(events); i++ {
		if len(heights) == 0 {
			res = append(res, events[i][0]-prev)
			prev = events[i][0]
		} else {
			res[len(res)-1] += events[i][0] - prev
			prev = events[i][0]
		}

		if events[i][2] == 1 {
			heights = append(heights, events[i][1])
			sort.Ints(heights)
		} else {
			for j := 0; j < len(heights); j++ {
				if heights[j] == events[i][1] {
					heights = append(heights[:j], heights[j+1:]...)
					break
				}
			}
		}

		if i < len(events)-1 && len(heights) == 0 && events[i+1][0] != prev {
			res = append(res, 0)
		}
	}

	return res
}