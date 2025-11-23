func numWaterBottles(numBottles int, numExchange int) int {
    totalDrunk := numBottles
    emptyBottles := numBottles

    for emptyBottles >= numExchange {
        newBottles := emptyBottles / numExchange
        totalDrunk += newBottles
        emptyBottles = newBottles + emptyBottles % numExchange
    }

    return totalDrunk
}