import "sort"

func meetingRoomsIII(n int, meetings [][]int) int {
	rooms := make([]int64, n)
	counts := make([]int, n)

	sort.Slice(meetings, func(i, j int) bool {
		return meetings[i][0] < meetings[j][0]
	})

	for _, meeting := range meetings {
		start, end := meeting[0], meeting[1]
		found := false
		minTime := int64(1<<62 - 1)
		minIdx := -1

		for i := 0; i < n; i++ {
			if rooms[i] <= int64(start) {
				counts[i]++
				rooms[i] = int64(end)
				found = true
				break
			}
			if rooms[i] < minTime {
				minTime = rooms[i]
				minIdx = i
			}
		}

		if !found {
			counts[minIdx]++
			rooms[minIdx] += int64(end - start)
		}
	}

	maxCount := 0
	maxIdx := 0
	for i := 0; i < n; i++ {
		if counts[i] > maxCount {
			maxCount = counts[i]
			maxIdx = i
		}
	}

	return maxIdx
}