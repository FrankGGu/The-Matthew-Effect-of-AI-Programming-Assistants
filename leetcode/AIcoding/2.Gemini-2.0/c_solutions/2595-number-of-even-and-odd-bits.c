#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* evenOddBit(int n, int* returnSize){
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = 0;
    result[1] = 0;
    *returnSize = 2;
    for (int i = 0; n > 0; i++) {
        if (n & 1) {
            if (i % 2 == 0) {
                result[0]++;
            } else {
                result[1]++;
            }
        }
        n >>= 1;
    }
    return result;
}