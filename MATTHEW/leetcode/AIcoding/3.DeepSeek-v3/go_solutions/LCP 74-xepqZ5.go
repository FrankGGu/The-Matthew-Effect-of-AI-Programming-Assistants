func fieldOfGreatestBlessing(forceField [][]int) int {
    events := make([][]float64, 0)
    for _, f := range forceField {
        x, y, side := float64(f[0]), float64(f[1]), float64(f[2])
        left, right := x-side/2, x+side/2
        bottom, top := y-side/2, y+side/2
        events = append(events, []float64{left, 1, bottom, top})
        events = append(events, []float64{right, -1, bottom, top})
    }
    sort.Slice(events, func(i, j int) bool {
        if events[i][0] != events[j][0] {
            return events[i][0] < events[j][0]
        }
        return events[i][1] < events[j][1]
    })

    active := make([][]float64, 0)
    res := 0
    for i := 0; i < len(events); {
        x := events[i][0]
        j := i
        for j < len(events) && events[j][0] == x {
            if events[j][1] == 1 {
                active = append(active, []float64{events[j][2], events[j][3]})
            } else {
                for k := 0; k < len(active); k++ {
                    if active[k][0] == events[j][2] && active[k][1] == events[j][3] {
                        active = append(active[:k], active[k+1:]...)
                        break
                    }
                }
            }
            j++
        }
        i = j

        if len(active) == 0 {
            continue
        }

        intervals := make([][]float64, len(active))
        copy(intervals, active)
        sort.Slice(intervals, func(i, j int) bool {
            if intervals[i][0] != intervals[j][0] {
                return intervals[i][0] < intervals[j][0]
            }
            return intervals[i][1] < intervals[j][1]
        })

        cnt := 0
        start, end := intervals[0][0], intervals[0][1]
        for _, interval := range intervals {
            if interval[0] <= end {
                if interval[1] > end {
                    end = interval[1]
                }
            } else {
                cnt += 1
                start, end = interval[0], interval[1]
            }
        }
        cnt += 1

        if cnt > res {
            res = cnt
        }
    }
    return res
}