#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int* powerfulIntegers(int x, int y, int z, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 1000);
    int count = 0;
    for (int i = 0; i <= z; i++) {
        for (int j = 0; j <= z; j++) {
            if (pow(x, i) + pow(y, j) <= z) {
                result[count++] = pow(x, i) + pow(y, j);
            }
        }
    }
    *returnSize = count;
    return result;
}