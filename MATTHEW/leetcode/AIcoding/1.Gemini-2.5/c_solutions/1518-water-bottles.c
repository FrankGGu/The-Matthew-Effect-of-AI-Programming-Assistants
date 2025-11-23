int numWaterBottles(int numBottles, int numExchange) {
    int drunkBottles = 0;
    int emptyBottles = 0;

    drunkBottles = numBottles;
    emptyBottles = numBottles;

    while (emptyBottles >= numExchange) {
        int newBottles = emptyBottles / numExchange;
        drunkBottles += newBottles;
        emptyBottles = (emptyBottles % numExchange) + newBottles;
    }

    return drunkBottles;
}