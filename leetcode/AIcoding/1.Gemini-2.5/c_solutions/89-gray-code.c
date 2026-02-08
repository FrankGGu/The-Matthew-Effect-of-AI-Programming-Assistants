#include <stdlib.h>

int* grayCode(int n, int* returnSize) {
    int size = 1 << n;
    int* result = (int*)malloc(size * sizeof(int));
    *returnSize = size;

    result[0] = 0;

    for (int i = 1; i <= n; i++) {
        int current_len = 1 << (i - 1);
        int val_to_add = 1 << (i - 1);
        for (int k = 0; k < current_len; k++) {
            result[current_len + k] = result[current_len - 1 - k] | val_to_add;
        }
    }

    return result;
}