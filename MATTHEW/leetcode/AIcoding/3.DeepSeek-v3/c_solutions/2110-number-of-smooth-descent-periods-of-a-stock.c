long long getDescentPeriods(int* prices, int pricesSize) {
    long long total = 1;
    long long current = 1;

    for (int i = 1; i < pricesSize; i++) {
        if (prices[i] == prices[i-1] - 1) {
            current++;
        } else {
            current = 1;
        }
        total += current;
    }

    return total;
}