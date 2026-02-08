#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxValue(int* values, int valuesSize, int* weights, int weightsSize, int capacity) {
    if (valuesSize == 0 || capacity == 0) {
        return 0;
    }

    int dp[capacity + 1];
    for (int i = 0; i <= capacity; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < valuesSize; i++) {
        for (int j = capacity; j >= weights[i]; j--) {
            dp[j] = (dp[j] > dp[j - weights[i]] + values[i]) ? dp[j] : dp[j - weights[i]] + values[i];
        }
    }

    return dp[capacity];
}