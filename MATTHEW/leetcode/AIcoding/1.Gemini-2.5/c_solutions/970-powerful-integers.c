#include <stdlib.h>
#include <stdbool.h>

int* powerfulIntegers(int x, int y, int bound, int* returnSize) {
    bool* seen = (bool*)calloc(bound + 1, sizeof(bool));
    if (seen == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int count = 0;
    int x_pow = 1;

    while (x_pow <= bound) {
        int y_pow = 1;
        while (x_pow + y_pow <= bound) {
            int sum = x_pow + y_pow;
            if (!seen[sum]) {
                seen[sum] = true;
                count++;
            }
            if (y == 1) {
                break;
            }
            if (y_pow > bound / y) { 
                break;
            }
            y_pow *= y;
        }
        if (x == 1) {
            break;
        }
        if (x_pow > bound / x) {
            break;
        }
        x_pow *= x;
    }

    int* result = (int*)malloc(count * sizeof(int));
    if (result == NULL) {
        free(seen);
        *returnSize = 0;
        return NULL;
    }

    int idx = 0;
    for (int i = 0; i <= bound; i++) {
        if (seen[i]) {
            result[idx++] = i;
        }
    }

    free(seen);
    *returnSize = count;
    return result;
}