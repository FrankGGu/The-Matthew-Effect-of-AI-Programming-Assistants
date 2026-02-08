#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findPossibleStableArrays(int n, int maxLength, int* returnSize) {
    int count = 0;
    for (int i = 0; i < (1 << n); i++) {
        int stable = 1;
        for (int j = 0; j < n - 1; j++) {
            if (((i >> j) & 1) && ((i >> (j + 1)) & 1)) {
                stable = 0;
                break;
            }
        }
        if (stable) {
            count++;
        }
    }

    int* result = (int*)malloc(count * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int index = 0;
    for (int i = 0; i < (1 << n); i++) {
        int stable = 1;
        for (int j = 0; j < n - 1; j++) {
            if (((i >> j) & 1) && ((i >> (j + 1)) & 1)) {
                stable = 0;
                break;
            }
        }
        if (stable) {
            result[index++] = i;
        }
    }

    *returnSize = count;
    return result;
}