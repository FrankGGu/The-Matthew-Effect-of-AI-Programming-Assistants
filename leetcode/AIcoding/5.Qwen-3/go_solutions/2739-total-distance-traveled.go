package main

func distanceTraveled(target int, speedLimit int, cars [][]int) int {
    sort.Slice(cars, func(i, j int) bool {
        return cars[i][0] < cars[j][0]
    })
    res := 0
    for _, car := range cars {
        pos, speed := car[0], car[1]
        if speed > speedLimit {
            res += (target - pos) * speed
        }
    }
    return res
}