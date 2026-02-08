#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfArrays(int n, int* differences, int differencesSize, int lower, int upper) {
    long long min_sum = 0, max_sum = 0, current_sum = 0;
    for (int i = 0; i < differencesSize; i++) {
        current_sum += differences[i];
        if (current_sum < min_sum) {
            min_sum = current_sum;
        }
        if (current_sum > max_sum) {
            max_sum = current_sum;
        }
    }
    long long min_val = lower + min_sum;
    long long max_val = upper + max_sum;
    if (max_val - min_val < 0) {
        return 0;
    }
    return upper - lower - (max_sum - min_sum) >= 0 ? (int)(upper - lower - (max_sum - min_sum) + 1) : 0;
}