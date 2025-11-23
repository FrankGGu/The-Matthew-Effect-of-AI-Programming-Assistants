import "sort"

func minAvailableDuration(slots1 [][]int, slots2 [][]int, duration int) []int {
	sort.Slice(slots1, func(i, j int) bool {
		return slots1[i][0] < slots1[j][0]
	})
	sort.Slice(slots2, func(i, j int) bool {
		return slots2[i][0] < slots2[j][0]
	})

	i := 0
	j := 0
	for i < len(slots1) && j < len(slots2) {
		start := max(slots1[i][0], slots2[j][0])
		end := min(slots1[i][1], slots2[j][1])
		if end-start >= duration {
			return []int{start, start + duration}
		}

		if slots1[i][1] < slots2[j][1] {
			i++
		} else {
			j++
		}
	}

	return []int{}
}

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

type Task struct {
    Start int
    End   int
}

func minInterval(intervals [][]int) int {
    tasks := make([]Task, len(intervals))
    for i, interval := range intervals {
        tasks[i] = Task{interval[0], interval[1]}
    }

    sort.Slice(tasks, func(i, j int) bool {
        return tasks[i].End < tasks[j].End
    })

    res := 0
    lastEnd := -1

    for _, task := range tasks {
        if task.Start > lastEnd {
            res += task.End - task.Start + 1
            lastEnd = task.End
        }
    }

    return res
}