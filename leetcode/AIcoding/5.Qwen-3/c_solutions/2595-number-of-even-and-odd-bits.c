#include <stdio.h>
#include <stdlib.h>

int* evenOddBit(int n, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = 0;
    result[1] = 0;

    for (int i = 0; i < 32; i++) {
        if ((n >> i) & 1) {
            if (i % 2 == 0) {
                result[0]++;
            } else {
                result[1]++;
            }
        }
    }

    *returnSize = 2;
    return result;
}