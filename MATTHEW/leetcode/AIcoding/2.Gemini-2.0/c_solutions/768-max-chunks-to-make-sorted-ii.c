#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxChunksToSorted(int* arr, int arrSize) {
    long long *prefixMax = (long long*)malloc(sizeof(long long) * arrSize);
    long long *suffixMin = (long long*)malloc(sizeof(long long) * arrSize);

    prefixMax[0] = arr[0];
    for (int i = 1; i < arrSize; i++) {
        prefixMax[i] = (arr[i] > prefixMax[i - 1]) ? arr[i] : prefixMax[i - 1];
    }

    suffixMin[arrSize - 1] = arr[arrSize - 1];
    for (int i = arrSize - 2; i >= 0; i--) {
        suffixMin[i] = (arr[i] < suffixMin[i + 1]) ? arr[i] : suffixMin[i + 1];
    }

    int chunks = 1;
    for (int i = 0; i < arrSize - 1; i++) {
        if (prefixMax[i] <= suffixMin[i + 1]) {
            chunks++;
        }
    }

    free(prefixMax);
    free(suffixMin);

    return chunks;
}