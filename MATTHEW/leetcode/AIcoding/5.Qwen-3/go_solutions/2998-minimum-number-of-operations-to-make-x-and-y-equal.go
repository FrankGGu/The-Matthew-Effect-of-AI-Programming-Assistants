package main

func minOperations(x int, y int, z int) int {
    if x == y {
        return 0
    }
    if z == 0 {
        return -1
    }
    var count int
    for x != y {
        if x > y {
            if x%z == 0 {
                x /= z
            } else {
                return -1
            }
        } else {
            if y%z == 0 {
                y /= z
            } else {
                return -1
            }
        }
        count++
    }
    return count
}