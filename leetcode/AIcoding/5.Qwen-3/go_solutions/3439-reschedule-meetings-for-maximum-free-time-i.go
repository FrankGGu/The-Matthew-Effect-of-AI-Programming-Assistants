package main

func maxFreeTime(rooms [][]int) int {
    events := make([][2]int, 0)
    for _, room := range rooms {
        for i := 0; i < len(room); i += 2 {
            start, end := room[i], room[i+1]
            events = append(events, [2]int{start, 1})
            events = append(events, [2]int{end, -1})
        }
    }

    sort.Slice(events, func(i, j int) bool {
        if events[i][0] != events[j][0] {
            return events[i][0] < events[j][0]
        }
        return events[i][1] < events[j][1]
    })

    maxFree := 0
    current := 0
    prevTime := 0

    for _, event := range events {
        time, delta := event[0], event[1]
        if current == 0 && prevTime != 0 {
            maxFree = max(maxFree, time-prevTime)
        }
        current += delta
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