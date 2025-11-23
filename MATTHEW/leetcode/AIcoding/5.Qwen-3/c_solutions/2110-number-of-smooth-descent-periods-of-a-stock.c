#include <stdio.h>
#include <stdlib.h>

long long numberOfSmoothDescentPeriods(long long* prices, int pricesSize) {
    long long count = 0;
    long long current = 1;
    for (int i = 1; i < pricesSize; i++) {
        if (prices[i-1] - prices[i] == 1) {
            current++;
        } else {
            current = 1;
        }
        count += current;
    }
    return count;
}