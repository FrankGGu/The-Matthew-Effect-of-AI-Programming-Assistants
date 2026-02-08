func numOfFlowersInFullBloom(flowers [][]int, persons []int) []int {
    events := make([][2]int, 0)
    for _, flower := range flowers {
        events = append(events, [2]int{flower[0], 1})
        events = append(events, [2]int{flower[1] + 1, -1})
    }
    for _, person := range persons {
        events = append(events, [2]int{person, 0})
    }

    sort.Slice(events, func(i, j int) bool {
        if events[i][0] == events[j][0] {
            return events[i][1] < events[j][1]
        }
        return events[i][0] < events[j][0]
    })

    result := make([]int, len(persons))
    count := 0
    personIndex := 0
    for _, event := range events {
        if event[1] == 1 {
            count++
        } else if event[1] == -1 {
            count--
        } else {
            result[personIndex] = count
            personIndex++
        }
    }

    return result
}