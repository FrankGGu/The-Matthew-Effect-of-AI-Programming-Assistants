var waterBottles = function(numBottles, numExchange) {
    let totalWater = numBottles;
    let emptyBottles = numBottles;

    while (emptyBottles >= numExchange) {
        const newBottles = Math.floor(emptyBottles / numExchange);
        totalWater += newBottles;
        emptyBottles = newBottles + (emptyBottles % numExchange);
    }

    return totalWater;
};