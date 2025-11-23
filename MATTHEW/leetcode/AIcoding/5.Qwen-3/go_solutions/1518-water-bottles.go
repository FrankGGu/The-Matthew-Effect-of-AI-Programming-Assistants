package main

func numWaterBottles(numBottles int, numExchange int) int {
    total := numBottles
    empty := numBottles
    for empty >= numExchange {
        newBottles := empty / numExchange
        total += newBottles
        empty = (empty % numExchange) + newBottles
    }
    return total
}