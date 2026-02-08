#include <stdlib.h>

int* findPeaks(int* mountains, int mountainsSize, int* returnSize) {
    int peakCount = 0;
    for (int i = 1; i < mountainsSize - 1; i++) {
        if (mountains[i] > mountains[i - 1] && mountains[i] > mountains[i + 1]) {
            peakCount++;
        }
    }

    *returnSize = peakCount;
    int* result = (int*)malloc(peakCount * sizeof(int));
    if (result == NULL && peakCount > 0) {
        // Handle malloc failure if necessary, though LeetCode usually assumes success
        return NULL;
    }

    int resultIndex = 0;
    for (int i = 1; i < mountainsSize - 1; i++) {
        if (mountains[i] > mountains[i - 1] && mountains[i] > mountains[i + 1]) {
            result[resultIndex++] = i;
        }
    }

    return result;
}