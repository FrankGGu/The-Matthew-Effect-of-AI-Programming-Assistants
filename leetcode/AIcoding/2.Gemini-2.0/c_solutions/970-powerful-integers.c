#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* powerfulIntegers(int x, int y, int bound, int* returnSize){
    if (bound <= 1) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(sizeof(int) * bound);
    *returnSize = 0;
    bool seen[bound + 1];
    for (int i = 0; i <= bound; i++) {
        seen[i] = false;
    }

    for (int i = 1; i <= bound; i *= x) {
        for (int j = 1; j <= bound; j *= y) {
            int sum = i + j;
            if (sum <= bound) {
                if (!seen[sum]) {
                    result[*returnSize] = sum;
                    (*returnSize)++;
                    seen[sum] = true;
                }
            }

            if (y == 1) break;
        }
        if (x == 1) break;
    }

    return result;
}