var numWaterBottles = function(numBottles, numExchange) {
    let total = numBottles;
    let empty = numBottles;

    while (empty >= numExchange) {
        const exchanged = Math.floor(empty / numExchange);
        total += exchanged;
        empty = exchanged + (empty % numExchange);
    }

    return total;
};