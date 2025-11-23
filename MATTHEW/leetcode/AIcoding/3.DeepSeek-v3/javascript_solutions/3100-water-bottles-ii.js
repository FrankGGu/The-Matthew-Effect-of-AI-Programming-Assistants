var maxBottlesDrunk = function(numBottles, numExchange) {
    let drunk = 0;
    let empty = 0;
    while (numBottles > 0 || empty >= numExchange) {
        drunk += numBottles;
        empty += numBottles;
        numBottles = 0;
        while (empty >= numExchange) {
            empty -= numExchange;
            numBottles++;
            numExchange++;
        }
    }
    return drunk;
};