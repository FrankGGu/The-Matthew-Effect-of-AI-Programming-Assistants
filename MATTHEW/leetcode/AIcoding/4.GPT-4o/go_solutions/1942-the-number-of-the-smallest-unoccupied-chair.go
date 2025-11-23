func smallestChair(chairs []int, guests []int) int {
    n := len(chairs)
    occupied := make([]bool, n)
    events := make([][2]int, len(guests)*2)

    for i, g := range(guests) {
        events[i*2] = [2]int{g, i} // guest arrival
        events[i*2+1] = [2]int{g + 1, -i} // guest leaving
    }

    sort.Slice(events, func(i, j int) bool {
        if events[i][0] == events[j][0] {
            return events[i][1] < events[j][1]
        }
        return events[i][0] < events[j][0]
    })

    availableChairs := make([]int, 0)
    for i := 0; i < n; i++ {
        availableChairs = append(availableChairs, i)
    }

    result := make([]int, len(guests))

    for _, event := range events {
        if event[1] >= 0 { // guest arrives
            if len(availableChairs) > 0 {
                chair := availableChairs[0]
                availableChairs = availableChairs[1:]
                result[event[1]] = chair
            }
        } else { // guest leaves
            chair := result[-event[1]]
            availableChairs = append(availableChairs, chair)
            sort.Ints(availableChairs)
        }
    }

    return result[0]
}