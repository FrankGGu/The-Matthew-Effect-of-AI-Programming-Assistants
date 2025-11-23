#include <stdio.h>
#include <stdlib.h>

int minOperations(int* target, int targetSize, int* original, int originalSize) {
    int* indices = (int*)malloc(targetSize * sizeof(int));
    int indexMap[100001] = {0};
    int mapSize = 0;

    for (int i = 0; i < targetSize; i++) {
        indexMap[target[i]] = i + 1;
    }

    for (int i = 0; i < originalSize; i++) {
        if (indexMap[original[i]] > 0) {
            indices[mapSize++] = indexMap[original[i]];
        }
    }

    int* dp = (int*)malloc(mapSize * sizeof(int));
    int len = 0;

    for (int i = 0; i < mapSize; i++) {
        int left = 0, right = len;
        while (left < right) {
            int mid = (left + right) / 2;
            if (dp[mid] < indices[i]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        if (left == len) {
            dp[len++] = indices[i];
        } else {
            dp[left] = indices[i];
        }
    }

    free(dp);
    free(indices);
    return targetSize - len;
}