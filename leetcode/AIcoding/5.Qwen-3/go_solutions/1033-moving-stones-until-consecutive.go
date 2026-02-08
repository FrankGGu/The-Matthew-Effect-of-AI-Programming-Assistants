package main

func numMovesStonesII(a int, b int, c int) int {
    x, y, z := a, b, c
    if x > y {
        x, y = y, x
    }
    if y > z {
        y, z = z, y
    }
    if x > y {
        x, y = y, x
    }
    if z-y == 1 && y-x == 1 {
        return 0
    }
    if z-y == 1 || y-x == 1 {
        return 1
    }
    return (z - x - 2)
}