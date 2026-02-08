package main

func maxFreeTime(schedule [][]int) int {
    // Flatten the schedule into a list of events (start and end times)
    events := make([][2]int, 0, len(schedule)*2)
    for _, s := range schedule {
        events = append(events, [2]int{s[0], 0})
        events = append(events, [2]int{s[1], 1})
    }

    // Sort the events by time, and by type (end before start to handle overlaps correctly)
    sort.Slice(events, func(i, j int) bool {
        if events[i][0] != events[j][0] {
            return events[i][0] < events[j][0]
        }
        return events[i][1] < events[j][1]
    })

    maxFree := 0
    prevTime := -1
    active := 0

    for _, event := range events {
        time := event[0]
        isStart := event[1] == 0

        if prevTime != -1 && !isStart && active == 0 {
            maxFree = max(maxFree, time-prevTime)
        }

        if isStart {
            active++
        } else {
            active--
        }

        prevTime = time
    }

    return maxFree
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}