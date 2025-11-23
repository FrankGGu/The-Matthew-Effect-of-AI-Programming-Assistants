var numWaterBottles = function(numBottles, numExchange) {
    let drunkBottles = numBottles;
    let emptyBottles = numBottles;

    while (emptyBottles >= numExchange) {
        let newBottles = Math.floor(emptyBottles / numExchange);
        drunkBottles += newBottles;
        emptyBottles = (emptyBottles % numExchange) + newBottles;
    }

    return drunkBottles;
};