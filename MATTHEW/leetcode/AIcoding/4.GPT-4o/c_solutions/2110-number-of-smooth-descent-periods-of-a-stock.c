int getDescentPeriods(int* prices, int pricesSize) {
    long long count = 1, total = 0;
    for (int i = 1; i < pricesSize; i++) {
        if (prices[i] == prices[i - 1] - 1) {
            count++;
        } else {
            count = 1;
        }
        total += count;
    }
    return total + 1; // Including the first day
}