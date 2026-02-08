package main

func carFleet(target int, position [][]int, speed []int) int {
    type Car struct {
        pos int
        spd int
    }
    cars := make([]Car, len(position))
    for i := range position {
        cars[i] = Car{position[i][0], speed[i]}
    }

    sort.Slice(cars, func(i, j int) bool {
        return cars[i].pos > cars[j].pos
    })

    stack := []float64{}
    for _, car := range cars {
        time := float64(target-car.pos) / float64(car.spd)
        if len(stack) == 0 || time > stack[len(stack)-1] {
            stack = append(stack, time)
        }
    }

    return len(stack)
}