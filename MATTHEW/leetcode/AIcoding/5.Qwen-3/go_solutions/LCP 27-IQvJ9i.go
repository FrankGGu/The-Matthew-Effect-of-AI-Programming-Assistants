package main

func blackBoxReflection(n int, m int, x int, y int) []int {
    dx := 1
    dy := 1
    if x > n/2 {
        dx = -1
    }
    if y > m/2 {
        dy = -1
    }
    stepsX := 0
    stepsY := 0
    if dx == 1 {
        stepsX = n - x
    } else {
        stepsX = x
    }
    if dy == 1 {
        stepsY = m - y
    } else {
        stepsY = y
    }
    if stepsX < stepsY {
        return []int{dx * (n - x), dy * y}
    } else {
        return []int{dx * x, dy * (m - y)}
    }
}