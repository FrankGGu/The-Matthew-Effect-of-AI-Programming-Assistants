#include <stdio.h>
#include <stdlib.h>

int maxChunksToMakeSorted(int* arr, int arrSize) {
    int maxSoFar = 0;
    int chunks = 0;
    for (int i = 0; i < arrSize; i++) {
        maxSoFar = (maxSoFar > arr[i]) ? maxSoFar : arr[i];
        if (maxSoFar == i) {
            chunks++;
        }
    }
    return chunks;
}