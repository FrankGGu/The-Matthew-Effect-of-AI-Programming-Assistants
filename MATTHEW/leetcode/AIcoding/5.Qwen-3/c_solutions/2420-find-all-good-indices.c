#include <stdio.h>
#include <stdlib.h>

int* findGoodIndices(int* arr, int arrSize, int k, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < arrSize; i++) {
        int isGood = 1;
        if (i - k >= 0 && i + k < arrSize) {
            for (int j = 1; j <= k; j++) {
                if (arr[i - j] > arr[i - j + 1] || arr[i + j] > arr[i + j + 1]) {
                    isGood = 0;
                    break;
                }
            }
            if (isGood) {
                result[count++] = i;
            }
        }
    }

    *returnSize = count;
    return result;
}