#include <stdio.h>
#include <stdlib.h>

int* rearrangeFruits(int* fruits, int fruitsSize, int k, int* returnSize) {
    int* result = (int*)malloc(fruitsSize * sizeof(int));
    *returnSize = fruitsSize;
    for (int i = 0; i < fruitsSize; i++) {
        result[i] = fruits[(i + k) % fruitsSize];
    }
    return result;
}