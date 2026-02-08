func rectangleArea(rectangles [][]int) int {
    const MOD = 1000000007
    events := make([][3]int, 0)

    for _, rect := range rectangles {
        events = append(events, [3]int{rect[1], rect[0], 1})
        events = append(events, [3]int{rect[3], rect[0], -1})
    }

    sort.Slice(events, func(i, j int) bool {
        if events[i][0] == events[j][0] {
            return events[i][1] < events[j][1]
        }
        return events[i][0] < events[j][0]
    })

    totalArea := 0
    prevY := 0
    active := make([]int, 0)

    for _, event := range events {
        y := event[0]
        x := event[1]
        typ := event[2]

        if len(active) > 0 {
            totalArea = (totalArea + (y-prevY)*calcLength(active)) % MOD
        }

        if typ == 1 {
            active = append(active, x)
        } else {
            for i := range active {
                if active[i] == x {
                    active = append(active[:i], active[i+1:]...)
                    break
                }
            }
        }

        prevY = y
    }

    return totalArea
}

func calcLength(active []int) int {
    if len(active) == 0 {
        return 0
    }

    sort.Ints(active)
    length := 0
    start := active[0]
    end := active[0]

    for _, x := range active {
        if x > end {
            length += end - start
            start = x
        }
        end = max(end, x)
    }

    length += end - start
    return length
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}