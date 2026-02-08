#include <limits.h> // Not strictly needed for this solution, but good practice for sums

long long maxCoins(int* coins, int coinsSize, int k) {
    if (coinsSize == 0 || k == 0 || k > coinsSize) {
        return 0;
    }

    long long current_window_sum = 0;
    for (int i = 0; i < k; i++) {
        current_window_sum += coins[i];
    }

    long long max_sum = current_window_sum;

    for (int i = k; i < coinsSize; i++) {
        current_window_sum = current_window_sum - coins[i - k] + coins[i];
        if (current_window_sum > max_sum) {
            max_sum = current_window_sum;
        }
    }

    return max_sum;
}