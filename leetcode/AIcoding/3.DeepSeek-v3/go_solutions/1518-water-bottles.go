func numWaterBottles(numBottles int, numExchange int) int {
    total := numBottles
    empty := numBottles
    for empty >= numExchange {
        exchanged := empty / numExchange
        total += exchanged
        empty = exchanged + empty % numExchange
    }
    return total
}