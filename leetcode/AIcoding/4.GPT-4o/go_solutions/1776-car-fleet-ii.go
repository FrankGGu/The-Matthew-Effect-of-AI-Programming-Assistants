func carFleet(target int, position []int, speed []int) int {
    n := len(position)
    cars := make([][2]int, n)

    for i := 0; i < n; i++ {
        cars[i] = [2]int{position[i], speed[i]}
    }

    sort.Slice(cars, func(i, j int) bool {
        return cars[i][0] > cars[j][0]
    })

    fleets := 0
    timeToReach := 0.0

    for _, car := range cars {
        pos, spd := float64(car[0]), float64(car[1])
        time := float64(target-pos) / spd

        if time > timeToReach {
            fleets++
            timeToReach = time
        }
    }

    return fleets
}