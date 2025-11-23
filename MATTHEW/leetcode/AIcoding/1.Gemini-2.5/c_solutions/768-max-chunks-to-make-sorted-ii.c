#include <stdlib.h> // For malloc, free
#include <limits.h> // For INT_MIN, INT_MAX (though not strictly necessary as initial values are from arr)

int maxChunksToSorted(int* arr, int arrSize) {
    if (arrSize == 0) {
        return 0;
    }
    if (arrSize == 1) {
        return 1;
    }

    int* leftMax = (int*)malloc(arrSize * sizeof(int));
    int* rightMin = (int*)malloc(arrSize * sizeof(int));

    leftMax[0] = arr[0];
    for (int i = 1; i < arrSize; i++) {
        leftMax[i] = (arr[i] > leftMax[i-1]) ? arr[i] : leftMax[i-1];
    }

    rightMin[arrSize - 1] = arr[arrSize - 1];
    for (int i = arrSize - 2; i >= 0; i--) {
        rightMin[i] = (arr[i] < rightMin[i+1]) ? arr[i] : rightMin[i+1];
    }

    int chunks = 1;
    for (int i = 0; i < arrSize - 1; i++) {
        if (leftMax[i] <= rightMin[i+1]) {
            chunks++;
        }
    }

    free(leftMax);
    free(rightMin);

    return chunks;
}