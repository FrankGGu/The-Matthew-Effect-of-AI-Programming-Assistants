#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int size;
} Result;

Result* findStableBinaryArrays(int n, int k, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (1 << n));
    int count = 0;

    for (int mask = 0; mask < (1 << n); mask++) {
        int valid = 1;
        for (int i = 0; i < n - k + 1; i++) {
            int submask = (mask >> i) & ((1 << k) - 1);
            int ones = 0;
            for (int j = 0; j < k; j++) {
                if (submask & (1 << j)) ones++;
            }
            if (ones > 1) {
                valid = 0;
                break;
            }
        }
        if (valid) {
            result[count++] = mask;
        }
    }

    Result* res = (Result*)malloc(sizeof(Result));
    res->data = result;
    res->size = count;
    *returnSize = count;
    return res;
}