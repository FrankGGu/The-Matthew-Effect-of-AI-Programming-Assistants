#include <stdlib.h>

int* missingRolls(int* rolls, int rollsSize, int mean, int m, int* returnSize) {
    long long total_observations = (long long)rollsSize + m;
    long long total_sum = mean * total_observations;

    long long rolls_sum = 0;
    for (int i = 0; i < rollsSize; i++) {
        rolls_sum += rolls[i];
    }

    long long missing_sum = total_sum - rolls_sum;

    if (missing_sum < m || missing_sum > (long long)m * 6) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(sizeof(int) * m);
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    long long remaining_to_distribute = missing_sum - m;

    for (int i = 0; i < m; i++) {
        result[i] = 1;
        int add_val = (remaining_to_distribute < 5) ? (int)remaining_to_distribute : 5;
        result[i] += add_val;
        remaining_to_distribute -= add_val;
    }

    *returnSize = m;
    return result;
}