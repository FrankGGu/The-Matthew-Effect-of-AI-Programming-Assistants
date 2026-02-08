package main

func rectangleArea(rectangles [][]int) int {
    const MOD = 1000000007
    events := make([][3]int, 0)
    for _, r := range rectangles {
        x1, y1, x2, y2 := r[0], r[1], r[2], r[3]
        events = append(events, [3]int{x1, y1, y2})
        events = append(events, [3]int{x2, y1, y2})
    }

    sort.Slice(events, func(i, j int) bool {
        return events[i][0] < events[j][0]
    })

    res := 0
    prevX := 0
    active := make(map[int]int)
    for i := 0; i < len(events); i++ {
        currX := events[i][0]
        if prevX != 0 && currX > prevX {
            totalHeight := 0
            for h := range active {
                totalHeight += h
            }
            res = (res + (currX - prevX) * totalHeight) % MOD
        }
        prevX = currX
        if i < len(events)-1 && events[i][0] == events[i+1][0] {
            continue
        }
        for j := i; j < len(events) && events[j][0] == currX; j++ {
            y1, y2 := events[j][1], events[j][2]
            if active[y1] == 0 {
                active[y1] = 1
            } else {
                active[y1]++
            }
            if active[y2] == 1 {
                delete(active, y2)
            } else {
                active[y2]--
            }
        }
        i = len(events)
    }
    return res
}