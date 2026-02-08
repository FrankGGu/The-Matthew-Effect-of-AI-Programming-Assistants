long long smoothDescentPeriods(int* prices, int pricesSize) {
    long long total_periods = 0;
    long long current_length = 0;

    for (int i = 0; i < pricesSize; ++i) {
        if (i == 0 || prices[i-1] - prices[i] != 1) {
            current_length = 1;
        } else {
            current_length++;
        }
        total_periods += current_length;
    }

    return total_periods;
}