int maxBottlesDrunk(int numBottles, int numExchange) {
    int drunkBottles = numBottles;
    int emptyBottles = numBottles;
    int currentExchangeCost = numExchange;

    while (emptyBottles >= currentExchangeCost) {
        drunkBottles += 1;
        emptyBottles = emptyBottles - currentExchangeCost + 1;
        currentExchangeCost += 1;
    }

    return drunkBottles;
}