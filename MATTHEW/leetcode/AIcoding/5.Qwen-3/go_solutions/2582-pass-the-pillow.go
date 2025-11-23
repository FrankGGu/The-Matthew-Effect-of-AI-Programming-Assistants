package main

func passThePillow(n int, time int) int {
    direction := 1
    current := 1
    for i := 0; i < time; i++ {
        if current == n {
            direction = -1
        } else if current == 1 {
            direction = 1
        }
        current += direction
    }
    return current
}