function numWaterBottles(numBottles, numExchange) {
    let total = numBottles;
    let empty = numBottles;

    while (empty >= numExchange) {
        let newBottles = Math.floor(empty / numExchange);
        total += newBottles;
        empty = newBottles + (empty % numExchange);
    }

    return total;
}