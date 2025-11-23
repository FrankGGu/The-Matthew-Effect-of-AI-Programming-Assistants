package main

func numWaterBottles(fullBottles int, emptyBottles int) int {
    total := fullBottles
    empty := fullBottles
    for empty >= 3 {
        newFull := empty / 3
        total += newFull
        empty = (empty % 3) + newFull
    }
    return total
}