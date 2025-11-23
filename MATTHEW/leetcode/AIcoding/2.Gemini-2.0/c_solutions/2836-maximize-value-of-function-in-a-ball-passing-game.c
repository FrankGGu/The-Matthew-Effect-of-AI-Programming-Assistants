#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long solve(int index, int k, int *arr, int arrSize) {
    long long current = index;
    for (int i = 0; i < k; i++) {
        current = arr[(int)current];
    }
    return current;
}

long long getMaxFunctionValue(int* arr, int arrSize, long long k) {
    long long max_val = 0;
    for (int i = 0; i < arrSize; i++) {
        long long current_val = solve(i, (int)k, arr, arrSize);
        if (current_val > max_val) {
            max_val = current_val;
        }
    }
    return max_val;
}