#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* fairCandySwap(int* aliceSizes, int aliceSizesSize, int* bobSizes, int bobSizesSize, int* returnSize){
    int sumA = 0, sumB = 0;
    for (int i = 0; i < aliceSizesSize; i++) {
        sumA += aliceSizes[i];
    }
    for (int i = 0; i < bobSizesSize; i++) {
        sumB += bobSizes[i];
    }

    int diff = (sumA - sumB) / 2;
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    for (int i = 0; i < aliceSizesSize; i++) {
        for (int j = 0; j < bobSizesSize; j++) {
            if (aliceSizes[i] - bobSizes[j] == diff) {
                result[0] = aliceSizes[i];
                result[1] = bobSizes[j];
                return result;
            }
        }
    }

    return result;
}