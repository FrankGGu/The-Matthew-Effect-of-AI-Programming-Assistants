#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* missingRolls(int* rolls, int rollsSize, int mean, int n, int* returnSize) {
    int sum_rolls = 0;
    for (int i = 0; i < rollsSize; i++) {
        sum_rolls += rolls[i];
    }

    int missing_sum = mean * (n + rollsSize) - sum_rolls;

    if (missing_sum < n || missing_sum > 6 * n) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int quotient = missing_sum / n;
    int remainder = missing_sum % n;

    for (int i = 0; i < n; i++) {
        result[i] = quotient;
        if (i < remainder) {
            result[i]++;
        }
    }

    return result;
}