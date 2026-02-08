#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long getDescentPeriods(int* prices, int pricesSize) {
    long long ans = 0;
    long long count = 1;
    for (int i = 1; i < pricesSize; i++) {
        if (prices[i] == prices[i - 1] - 1) {
            count++;
        } else {
            ans += count * (count + 1) / 2;
            count = 1;
        }
    }
    ans += count * (count + 1) / 2;
    return ans;
}