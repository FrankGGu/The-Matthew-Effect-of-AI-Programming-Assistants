#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* pancakeSort(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(arrSize * 2 * sizeof(int));
    *returnSize = 0;

    for (int i = arrSize; i > 1; i--) {
        int maxIndex = 0;
        for (int j = 1; j < i; j++) {
            if (arr[j] > arr[maxIndex]) {
                maxIndex = j;
            }
        }

        if (maxIndex != i - 1) {
            if (maxIndex != 0) {
                result[(*returnSize)++] = maxIndex + 1;
                for (int k = 0; k <= maxIndex / 2; k++) {
                    int temp = arr[k];
                    arr[k] = arr[maxIndex - k];
                    arr[maxIndex - k] = temp;
                }
            }

            result[(*returnSize)++] = i;
            for (int k = 0; k < i / 2; k++) {
                int temp = arr[k];
                arr[k] = arr[i - 1 - k];
                arr[i - 1 - k] = temp;
            }
        }
    }

    return result;
}