type Event struct {
    x, y1, y2 int
    typ       int
}

func rectangleArea(rectangles [][]int) int {
    events := make([]Event, 0)
    for _, r := range rectangles {
        x1, y1, x2, y2 := r[0], r[1], r[2], r[3]
        events = append(events, Event{x1, y1, y2, 1})
        events = append(events, Event{x2, y1, y2, -1})
    }
    sort.Slice(events, func(i, j int) bool {
        return events[i].x < events[j].x
    })

    active := make([][]int, 0)
    res, prevX := 0, 0

    for i := 0; i < len(events); {
        currX := events[i].x
        if len(active) > 0 {
            res += (currX - prevX) * calcActiveLength(active)
        }
        for i < len(events) && events[i].x == currX {
            e := events[i]
            if e.typ == 1 {
                active = append(active, []int{e.y1, e.y2})
            } else {
                for j := 0; j < len(active); j++ {
                    if active[j][0] == e.y1 && active[j][1] == e.y2 {
                        active = append(active[:j], active[j+1:]...)
                        break
                    }
                }
            }
            i++
        }
        prevX = currX
    }
    return res % (1e9 + 7)
}

func calcActiveLength(active [][]int) int {
    intervals := make([][]int, len(active))
    copy(intervals, active)
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][0] < intervals[j][0]
    })

    res := 0
    start, end := intervals[0][0], intervals[0][1]
    for i := 1; i < len(intervals); i++ {
        if intervals[i][0] <= end {
            if intervals[i][1] > end {
                end = intervals[i][1]
            }
        } else {
            res += end - start
            start, end = intervals[i][0], intervals[i][1]
        }
    }
    res += end - start
    return res
}