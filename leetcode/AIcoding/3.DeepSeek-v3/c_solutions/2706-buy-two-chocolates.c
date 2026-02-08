int buyChoco(int* prices, int pricesSize, int money) {
    int min1 = 1000, min2 = 1000;
    for (int i = 0; i < pricesSize; i++) {
        if (prices[i] < min1) {
            min2 = min1;
            min1 = prices[i];
        } else if (prices[i] < min2) {
            min2 = prices[i];
        }
    }
    int total = min1 + min2;
    return total <= money ? money - total : money;
}