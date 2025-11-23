func maxBottlesDrunk(numBottles int, numExchange int) int {
    total := numBottles
    empty := numBottles
    for empty >= numExchange {
        empty -= numExchange
        numExchange++
        total++
        empty++
    }
    return total
}