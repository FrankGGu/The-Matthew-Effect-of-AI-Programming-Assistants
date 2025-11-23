var numWaterBottles = function(numBottles, numExchange) {
    let drunk = numBottles;
    let empty = numBottles;

    while (empty >= numExchange) {
        let newBottles = Math.floor(empty / numExchange);
        drunk += newBottles;
        empty = empty % numExchange + newBottles;
    }

    return drunk;
};