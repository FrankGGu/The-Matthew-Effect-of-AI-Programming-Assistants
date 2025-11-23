func carFleet(target int, position []int, speed []int) int {
    n := len(position)
    pairs := make([][2]int, n)
    for i := 0; i < n; i++ {
        pairs[i] = [2]int{position[i], speed[i]}
    }

    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i][0] > pairs[j][0]
    })

    fleets := 0
    timeToReach := 0.0

    for _, pair := range pairs {
        pos, spd := pair[0], pair[1]
        t := float64(target-pos) / float64(spd)
        if t > timeToReach {
            fleets++
            timeToReach = t
        }
    }

    return fleets
}