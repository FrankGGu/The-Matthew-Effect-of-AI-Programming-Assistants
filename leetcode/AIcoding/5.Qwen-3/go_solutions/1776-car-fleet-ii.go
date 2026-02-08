package main

func getCollisionTimes(cars [][]int) []int {
    n := len(cars)
    res := make([]int, n)
    stack := []int{}

    for i := n - 1; i >= 0; i-- {
        speed := cars[i][1]
        while len(stack) > 0 {
            next := stack[len(stack)-1]
            nextSpeed := cars[next][1]
            if speed <= nextSpeed {
                stack = stack[:len(stack)-1]
            } else {
                timeToCollision := (cars[next][0] - cars[i][0]) / (speed - nextSpeed)
                if res[next] == 0 || timeToCollision < res[next] {
                    res[i] = timeToCollision
                } else {
                    res[i] = 0
                }
                break
            }
        }
        stack = append(stack, i)
    }

    return res
}