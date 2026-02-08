package main

func orchestraLayout(x int, y int) int {
    maxDim := x
    if y > x {
        maxDim = y
    }
    side := maxDim * 2 - 1
    layer := 0
    if x < y {
        layer = x
    } else {
        layer = y
    }
    layer++
    top := layer * 2 - 1
    left := layer * 2 - 1
    right := side - layer * 2 + 1
    bottom := side - layer * 2 + 1
    total := 0
    for i := 1; i < layer; i++ {
        total += (side - 2*(i-1)) * 4 - 4
    }
    if x == layer-1 {
        return total + y - layer + 1
    } else if y == side - layer + 1 {
        return total + (side - 2*(layer-1))
    } else if x == side - layer + 1 {
        return total + (side - 2*(layer-1)) + (side - 2*(layer-1) - 1)
    } else {
        return total + (side - 2*(layer-1)) + (side - 2*(layer-1) - 1) + (side - 2*(layer-1) - 1)
    }
}